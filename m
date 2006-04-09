From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: [RFH] Exploration of an alternative diff_delta() algorithm
Date: Mon, 10 Apr 2006 00:45:48 +0200
Message-ID: <20060409224548.GB21455@erlang.gbar.dtu.dk>
References: <20060409143117.GA23908@erlang.gbar.dtu.dk> <Pine.LNX.4.64.0604091307460.2215@localhost.localdomain> <20060409173409.GB23908@erlang.gbar.dtu.dk> <Pine.LNX.4.64.0604091340540.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 10 00:46:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSifO-0006WS-T8
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 00:45:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWDIWpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 18:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWDIWpv
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 18:45:51 -0400
Received: from erlang.gbar.dtu.dk ([192.38.95.25]:28830 "HELO
	erlang.gbar.dtu.dk") by vger.kernel.org with SMTP id S1750959AbWDIWpu
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Apr 2006 18:45:50 -0400
Received: (qmail 14328 invoked by uid 5842); 10 Apr 2006 00:45:48 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604091340540.2215@localhost.localdomain>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18570>

On Sun, Apr 09, 2006 at 01:45:00PM -0400, Nicolas Pitre wrote:
...
> Try this with the README file from the git source tree:
> 
> 	sed s/git/GIT/g < ./README > /tmp/README.mod
> 	test-delta -d ./README /tmp/README.mod /tmp/README.delta
> 	[BOOM!]

I found the bug.  The code still has some limitations, but now
it passes the test suite.  Thanks for your help, Nicolas.

Peter

----->8---diff-delta.c---->8-------
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
  unsigned int index;
  unsigned int l;
  unsigned char* base = from_buf;
  unsigned char* version = to_buf;
  unsigned long base_size = from_size;
  unsigned long version_size = to_size;

  unsigned char* base_copy = base;
  unsigned char* version_copy = version;
  struct entry* table = calloc(HASH_TABLE_SIZE, sizeof(struct entry));
  //int delta_alloc = DELTA_SIZE;
  unsigned char* delta = malloc(DELTA_SIZE);
  unsigned int deltapos = 0;
  unsigned char* base_top = base + base_size;
  unsigned char* version_top = version + version_size;

  encode_size(delta, &deltapos, base_size);
  encode_size(delta, &deltapos, version_size);

  unsigned char* base_offset = base;
  unsigned char* version_offset = version;
  unsigned int base_hash = init_hash(base);
  unsigned int version_hash = init_hash(version);
  unsigned char* version_start = version;

  while(base_offset - base + PREFIX_SIZE < base_top - base && 
	version_offset - version + PREFIX_SIZE < version_top - version) {  
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
    while(base_copy[l] == version_copy[l] && base_copy + l < base_top && version_copy + l < version_top) l++;
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

	//fprintf(stdout, "add: pos %u, v_start %u, v_copy %u\n", 
	//	deltapos, version_start - version, version_copy - version);	


    // step4:
    encode_add(delta, &deltapos, version_start, version_copy);

	//fprintf(stdout, "copy: pos %u, v_copy %u, l %u\n", 
	//	deltapos, base_copy - base, l);	


    encode_copy(delta, &deltapos, base_copy - base, l);
    
    // step5:
    flush(table);
    
    version_start = version_offset;
    
    base_hash = init_hash(base_offset);
    version_hash = init_hash(version_offset);
    
	//fprintf(stdout, "3) pos %u, v_start %u, v %u, b %u\n", 
	//	deltapos, version_start - version, version_offset - version, base_offset- base);	
  }  //  goto step2;
  
	//fprintf(stdout, "pos %u, v_start %u, v_top %u\n", 
	//	deltapos, version_start - version, version_size);	
  encode_add(delta, &deltapos, version_start, version + version_size);
  *delta_size = deltapos;
  free(table);
  return delta;
}
