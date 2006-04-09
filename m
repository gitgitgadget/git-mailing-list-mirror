From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Sun, 9 Apr 2006 16:31:17 +0200
Message-ID: <20060409143117.GA23908@erlang.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 09 16:31:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSawm-0000jL-GG
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 16:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWDIObV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 10:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDIObV
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 10:31:21 -0400
Received: from erlang.gbar.dtu.dk ([192.38.95.25]:27787 "HELO
	erlang.gbar.dtu.dk") by vger.kernel.org with SMTP id S1750744AbWDIObV
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 10:31:21 -0400
Received: (qmail 149 invoked by uid 5842); 9 Apr 2006 16:31:17 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18547>

Greetings Gitlings,

I've been trying to implement an alternative algorithm
for diff_delta().  I'm getting close to something that
works, but now I'm stuck!  I think it has something to
do with pack-objects.c, but I'm not sure.  Here's the
first test that fails:

*** t5500-fetch-pack.sh ***
* FAIL 1: 1st pull
        git-fetch-pack -v .. B A > log.txt 2>&1
* FAIL 2: fsck
        git-fsck-objects --full > fsck.txt 2>&1
* FAIL 3: new object count after 1st pull
        test 33 = 0
* FAIL 4: minimal count
        test 33 = 0
* FAIL 5: repack && prune-packed in client
        (git-repack && git-prune-packed)2>>log.txt
*   ok 5: 2nd pull
*   ok 6: fsck
* FAIL 7: new object count after 2nd pull
        test 192 = 198
* FAIL 8: minimal count
        test 192 = 198
* FAIL 9: repack && prune-packed in client
        (git-repack && git-prune-packed)2>>log.txt
*   ok 9: 3rd pull
*   ok 10: fsck
* FAIL 11: new object count after 3rd pull
        test 3 = 228
* FAIL 12: minimal count
        test 3 = 30
* failed 8 among 12 test(s)

I've been looking all around the current diff_delta(), and I
can't see, what I'm missing.  Any ideas?  The file is meant to
replace the current diff-delta.c.

Peter

----->8--diff-delta.c----->8----
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "delta.h"


#define BASE 257
#define PREFIX_SIZE 3

#define SIZE 10
#define HASH_TABLE_SIZE (1<<SIZE)

#define DELTA_SIZE (1024 * 1024)


unsigned int init_hash(unsigned char* data) {
  return data[0]*BASE*BASE + data[1]*BASE + data[2];
}

unsigned int hash(unsigned char* data, unsigned int hash) {
  return (hash - data[-1]*BASE*BASE)*BASE + data[2];
}

#define GR_PRIME 0x9e370001
#define HASH(v) ((v * GR_PRIME) >> (32 - SIZE))

struct entry {
  char file;
  char* offset;
};


void flush(struct entry* table) {
  memset(table, 0, HASH_TABLE_SIZE * sizeof(struct entry));
}


int same_prefixes(char* data1, char* data2) {
  return !memcmp(data1, data2, PREFIX_SIZE);  
}


void encode_add(char* out, int* outpos, char* version_start, char* version_copy) {
  unsigned int size = version_copy - version_start;
  if (!size) return;
  int pos = *outpos;

  while(size > 127) {
    out[pos++] = 127;
    memcpy(out + pos, version_start, 127);
    pos += 127;
    version_start += 127;
    size -= 127;
  }
  out[pos++] = size;
  memcpy(out + pos, version_start, size);  
  pos += size;

  *outpos = pos;
}


void encode_copy(char* out, int* outpos, int offset, int size) {
     int pos = (*outpos) + 1;
     int i = 0x80;

     if (offset & 0xff) { out[pos++] = offset; i |= 0x01; }
     offset >>= 8;
     if (offset & 0xff) { out[pos++] = offset; i |= 0x02; }
     offset >>= 8;
     if (offset & 0xff) { out[pos++] = offset; i |= 0x04; }
     offset >>= 8;
     if (offset & 0xff) { out[pos++] = offset; i |= 0x08; }

     if (size & 0xff) { out[pos++] = size; i |= 0x10; }
     size >>= 8;
     if (size & 0xff) { out[pos++] = size; i |= 0x20; }

     out[*outpos] = i;
     *outpos = pos;
}



void encode_size(char* out, int* outpos, unsigned long size) {
  int pos = *outpos;
  out[pos] = size;
  size >>= 7;
  while (size) {
    out[pos++] |= 0x80;
    out[pos] = size;
    size >>= 7;
  }
  *outpos = ++pos;
}


void *diff_delta(void *from_buf, unsigned long from_size,
		 void *to_buf, unsigned long to_size,
		 unsigned long *delta_size,
		 unsigned long max_size) {
  int index;
  int l;
  char* base = from_buf;
  char* version = to_buf;
  unsigned long base_size = from_size;
  unsigned long version_size = to_size;

  char* base_copy = base;
  char* version_copy = version;
  struct entry* table = calloc(HASH_TABLE_SIZE, sizeof(struct entry));
  //int delta_alloc = DELTA_SIZE;
  char* delta = malloc(DELTA_SIZE);
  int deltapos = 0;
  char* base_top = base + base_size;
  char* version_top = version + version_size;

  encode_size(delta, &deltapos, base_size);
  encode_size(delta, &deltapos, version_size);

  char* base_offset = base;
  char* version_offset = version;
  unsigned int base_hash = init_hash(base);
  unsigned int version_hash = init_hash(version);
  char* version_start = version;

  while(base_offset + PREFIX_SIZE < base_top && 
	version_offset  + PREFIX_SIZE < version_top) {  
    // step2:
    
    index = HASH(base_hash);
    switch (table[index].file) {
    case '\0': {
      table[index].file = 'b';
      table[index].offset = base_offset;
      break;
    }
    case 'v': {
      if (same_prefixes(base_offset, table[index].offset)) {
	base_copy = base_offset;
	version_copy = table[index].offset;
	goto step3;
      } else break;
    }
    case 'b': break;
    default: printf("AAAAAARGH 2b\n");
    }
    
    index = HASH(version_hash);
    switch (table[index].file) {
    case '\0': {
      table[index].file = 'v';
      table[index].offset = version_offset;
      break;
    }
    case 'b': {
      if (same_prefixes(table[index].offset, version_offset)) {
	base_copy = table[index].offset;
	version_copy = version_offset;
	goto step3;
      } else break;
    }
    case 'v': break;
    default: printf("AAAAAARGH 2v\n");
    }
    
    base_offset++;
    version_offset++;

    base_hash = hash(base_offset, base_hash);
    version_hash = hash(version_offset, version_hash);
    continue;  //  goto step2;
    
  step3:
    l = 0;
    while(base_copy[l] == version_copy[l]) l++;
    base_offset = base_copy + l;
    version_offset = version_copy + l;
    
    /*
    // Make sure we don't run out of delta buffer when encoding.
    if((delta_alloc - deltapos) < 
       (version_start - version_copy) + 1 + 8 + (PREFIX_SIZE + 1)) {
      delta_alloc = delta_alloc * 3 / 2;
      delta = (char*) realloc(delta, delta_alloc);
    }
    */
	if(max_size && deltapos > max_size) {
		free(delta);
		free(table);
		return NULL;
	}

    // step4:
    encode_add(delta, &deltapos, version_start, version_copy);
    encode_copy(delta, &deltapos, base_copy - base, l);
    
    // step5:
    flush(table);
    
    version_start = version_offset;
    
    base_hash = init_hash(base_offset);
    version_hash = init_hash(version_offset);
    
  }  //  goto step2;
  
  encode_add(delta, &deltapos, version_start, version + version_size);
  *delta_size = deltapos;

  free(table);

  return delta;
}
