From: Geert Bosch <bosch@adacore.com>
Subject: Re: Fix up diffcore-rename scoring
Date: Thu, 6 Apr 2006 17:01:04 -0400
Message-ID: <DFDDA9C5-D8D2-413F-8A06-4D727C8F9EED@adacore.com>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org> <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603122256550.3618@g5.osdl.org> <Pine.LNX.4.64.0603122316160.3618@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-5-693823301
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 06 23:43:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRcGC-0005Kk-F2
	for gcvg-git@gmane.org; Thu, 06 Apr 2006 23:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWDFVnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Apr 2006 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWDFVnH
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Apr 2006 17:43:07 -0400
Received: from nile.gnat.com ([205.232.38.5]:52923 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1751210AbWDFVnF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Apr 2006 17:43:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 5719D48CDD4;
	Thu,  6 Apr 2006 17:43:00 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 12158-01-3; Thu,  6 Apr 2006 17:43:00 -0400 (EDT)
Received: from [172.16.1.2] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	by nile.gnat.com (Postfix) with ESMTP id 77BDB48CCBA;
	Thu,  6 Apr 2006 17:42:59 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0603122316160.3618@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18482>


--Apple-Mail-5-693823301
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Mar 13, 2006, at 02:44, Linus Torvalds wrote:
> It might be that the fast delta thing is a good way to ask "is this  
> even
> worth considering", to cut down the O(m*n) rename/copy detection to
> something much smaller, and then use xdelta() to actually figure  
> out what
> is a good rename and what isn't from a much smaller set of potential
> targets.

Here's a possible way to do that first cut. Basically,
compute a short (256-bit) fingerprint for each file, such
that the Hamming distance between two fingerprints is a measure
for their similarity. I'll include a draft write up below.

My initial implementation seems reasonably fast, works
great for 4000 (decompressed) files (25M) randomly plucked
from an old git.git repository without packs. It works OK for
comparing tar archives for GCC releases, but then it becomes
clear that random walks aren't that random anymore and
become dominated by repeated information, such as tar headers.

Speed is about 10MB/sec on my PowerBook, but one could cache
fingerprints so they only need to be computed once.
The nice thing is that one can quickly find similar files
only using the fingerprint (and in practice file size),
no filenames: this seems to fit the git model well.

I'll attach my test implementation below, it uses
David Mazieres Rabinpoly code and D. Phillips's fls code.
Please don't mind my C coding, it's not my native language.
Also, this may have some Darwinisms, although it should
work on Linux too.

   -Geert

Estimating Similarity

For estimating similarity between strings A and B, let
SA and SB be the collection of all substrings with length
W of A and B. Similarity now is defined as the ratio of
the intersection and the union of SA and SB.

The length W of these substrings is the window size, and here is
chosen somewhat arbitrarily to be 48. The idea is to make them not
so short that all context is lost (like counting symbol frequencies),
but not so long that a few small changes can affect a large portion
of substrings.  Of course, a single symbol change may affect up to
48 substrings.

Let "&" be the string concatenation operator.
If A = S2 & S1 & S2 & S3 & S2, and B = S2 & S3 & S2 & S1 & S2,
then if the length of S2 is at least W - 1, the strings
will have the same set of substrings and be considered equal
for purpose of similarity checking.  This behavior is actually
welcome, since reordering sufficiently separated pieces of a
document do not make it substantially different.

Instead of computing the ratio of identical substrings directly,
compute a 1-bit hash for each substring and calculate the difference
between the number of zeroes and ones. If the hashes appear random,
this difference follows a binomial distribution. Two files are
considered "likely similar" if their differences have the same sign.

The assumption that the hashes are randomly distributed, is not
true if there are many repeated substrings. For most applications,
it will be sufficient to ignore such repetitions (by using a small
cache of recently encountered hashes) as they do not convey much
actual information. For example, for purposes of finding small
deltas between strings, duplicating existing text will not significantly
increase the delta.

For a string with N substrings, of which K changed, perform a random
walk of N steps in 1-dimensional space (see [1]): what is the  
probability
the origin was crossed an odd number of times in the last K steps?
As the expected distance is Sqrt (2 * N / Pi), this probability
gets progressively smaller for larger N and a given ratio of N and K.
For larger files, the result should be quite stable.


In order to strengthen this similarity check and be able to
quantify the degree of similarity, many independent 1-bit hashes
are computed and counted for each string and assembled into
a bit vector of 256 bits, called the fingerprint. Each bit
of the fingerprint represents the result of independent
statistical experiment. For similar strings, corresponding bits
are more likely to be the same than for random strings.

For efficiency, a 64-bit hash is computed using a irreducible
Rabin polynomial of degree 63. The algebraic properties
of these allow for efficient calculation over a sliding window
of the input. [2] As the cryptographic advantages of randomly
generated hash functions are not required, a fixed polynomial
has been chosen.

This 64-bit hash is expanded to 256 bits by using three bits
to select 32 of the 256 bits in the fingerprint to update.
So, for every 8-bit character the polynomial needs updating,
and 32 counters are incremented or decremented.
So, each of the 256 counters represents a random walk that
is N / 4, for a string of length N.

The similarity of A and B can now be expressed as the Hamming
distance between the two bit vectors, divided by the expected
distance between two random vectors. This similarity score is
a number between 0 and 2, where smaller values mean the strings
are more similar, and values of 1 or more mean they are dissimilar.

One of the unique properties of this fingerprint is the
ability to compare files in different locations by only
transmitting their fingerprint.



--Apple-Mail-5-693823301
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="gsimm.c"
Content-Disposition: attachment;
	filename=gsimm.c

#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <libgen.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>

#include "rabinpoly.h"

/* Length of file message digest (MD) in bytes. Longer MD's are
   better, but increase processing time for diminishing returns.
   Must be multiple of NUM_HASHES_PER_CHAR / 8, and at least 24
   for good results 
*/
#define MD_LENGTH 32
#define MD_BITS (MD_LENGTH * 8)

/* Has to be power of two. Since the Rabin hash only has 63
   usable bits, the number of hashes is limited to 32.
   Lower powers of two could be used for speeding up processing
   of very large files.  */
#define NUM_HASHES_PER_CHAR 32


/* For the final counting, do not count each bit individually, but
   group them. Must be power of two, at most NUM_HASHES_PER_CHAR.
   However, larger sizes result in higher cache usage. Use 8 bits
   per group for efficient processing of large files on fast machines
   with decent caches, or 4 bits for faster processing of small files
   and for machines with small caches.  */
#define GROUP_BITS 4
#define GROUP_COUNTERS (1<<GROUP_BITS)


/* The RABIN_WINDOW_SIZE is the size of fingerprint window used by 
   Rabin algorithm. This is not a modifiable parameter.

   The first RABIN_WINDOW_SIZE - 1 bytes are skipped, in order to ensure
   fingerprints are good hashes. This does somewhat reduce the
   influence of the first few bytes in the file (they're part of
   fewer windows, like the last few bytes), but that actually isn't
   so bad as files often start with fixed content that may bias comparisons.
*/

/* The MIN_FILE_SIZE indicates the absolute minimal file size that
   can be processed. As indicated above, the first and last 
   RABIN_WINDOW_SIZE - 1 bytes are skipped. 
   In order to get at least an average of 12 samples
   per bit in the final message digest, require at least 3 * MD_LENGTH
   complete windows in the file.  */
#define MIN_FILE_SIZE (3 * MD_LENGTH + 2 * (RABIN_WINDOW_SIZE - 1))

/* Limit matching algorithm to files less than 256 MB, so we can use
   32 bit integers everywhere without fear of overflow. For larger
   files we should add logic to mmap the file by piece and accumulate
   the frequency counts. */
#define MAX_FILE_SIZE (256*1024*1024 - 1)

/* Size of cache used to eliminate duplicate substrings.
   Make small enough to comfortably fit in L1 cache.  */
#define DUP_CACHE_SIZE 256

#define MIN(x,y) ((y)<(x) ? (y) : (x))
#define MAX(x,y) ((y)>(x) ? (y) : (x))

typedef struct fileinfo
{ char		*name;
  size_t	length;
  u_char	md[MD_LENGTH];
  int		match;
} File;

int flag_verbose = 0;
int flag_debug = 0;
int flag_warning = 0;
char *flag_relative = 0;

char cmd[12] = "        ...";
char md_strbuf[MD_LENGTH * 2 + 1];
u_char relative_md [MD_LENGTH];

File *file;
int    file_count;
size_t file_bytes;

FILE *msgout;

char hex[17] = "0123456789abcdef";
double pi = 3.14159265358979323844;

int freq[MD_BITS];
u_int64_t freq_dups = 0;

void usage()
{  fprintf (stderr, "usage: %s [-dhvw] [-r fingerprint] file ...\n", cmd);
   fprintf (stderr, " -d\tdebug output, repeate for more verbosity\n");
   fprintf (stderr, " -h\tshow this usage information\n");
   fprintf (stderr, " -r\tshow distance relative to fingerprint "
                    "(%u hex digits)\n", MD_LENGTH * 2);
   fprintf (stderr, " -v\tverbose output, repeat for even more verbosity\n");
   fprintf (stderr, " -w\tenable warnings for suspect statistics\n");
   exit (1);
}

int dist (u_char *l, u_char *r)
{ int j, k;
  int d = 0;

  for (j = 0; j < MD_LENGTH; j++)
  { u_char ch = l[j] ^ r[j];

    for (k = 0; k < 8; k++) d += ((ch & (1<<k)) > 0);
  } 

  return d;
}

char *md_to_str(u_char *md)
{ int j;

  for (j = 0; j < MD_LENGTH; j++)
  { u_char ch = md[j];

    md_strbuf[j*2] = hex[ch >> 4];
    md_strbuf[j*2+1] = hex[ch & 0xF];
  }

  md_strbuf[j*2] = 0;
  return md_strbuf;
}

u_char *str_to_md(char *str, u_char *md)
{ int j;

  if (!md || !str) return 0;

  bzero (md, MD_LENGTH);
  
  for (j = 0; j < MD_LENGTH * 2; j++)
  { char ch = str[j];

    if (ch >= '0' && ch <= '9')
    { md [j/2] = (md [j/2] << 4) + (ch - '0'); 
    }
    else
    { ch |= 32;

      if (ch < 'a' || ch > 'f') break;
      md [j/2] = (md[j/2] << 4) + (ch - 'a' + 10);
  } } 

  return (j != MD_LENGTH * 2 || str[j] != 0) ? 0 : md;
}
    
void freq_to_md(u_char *md)
{ int j, k;
  int num = MD_BITS;

  for (j = 0; j < MD_LENGTH; j++)
  { u_char ch = 0;

    for (k = 0; k < 8; k++) ch = 2*ch + (freq[8*j+k] > 0);
    md[j] = ch;
  }

  if (flag_debug)
  { for (j = 0; j < num; j++)
    { if (j % 8 == 0) printf ("\n%3u: ", j);
      printf ("%7i ", freq[j]);
    }
    printf ("\n");
  }
  bzero (freq, sizeof(freq));
  freq_dups = 0;
}

void process_data (char *name, u_char *data, unsigned len, u_char *md)
{ size_t j = 0;
  u_int32_t ofs;
  u_int32_t dup_cache[DUP_CACHE_SIZE];
  u_int32_t count [MD_BITS * (GROUP_COUNTERS/GROUP_BITS)];
  bzero (dup_cache, DUP_CACHE_SIZE * sizeof (u_int32_t));
  bzero (count, (MD_BITS * (GROUP_COUNTERS/GROUP_BITS) * sizeof (u_int32_t)));

  /* Ignore incomplete substrings */
  while (j < len && j < RABIN_WINDOW_SIZE) rabin_slide8 (data[j++]);

  while (j < len)
  { u_int64_t hash;
    u_int32_t ofs, sum;
    u_char idx;
    int k;

    hash = rabin_slide8 (data[j++]);

    /* In order to update a much larger frequency table
       with only 32 bits of checksum, randomly select a
       part of the table to update. The selection should
       only depend on the content of the represented data,
       and be independent of the bits used for the update.
       
       Instead of updating 32 individual counters, process
       the checksum in MD_BITS / GROUP_BITS groups of 
       GROUP_BITS bits, and count the frequency of each bit pattern.
    */

    idx = (hash >> 32);
    sum = (u_int32_t) hash;
    ofs = idx % (MD_BITS / NUM_HASHES_PER_CHAR) * NUM_HASHES_PER_CHAR;
    idx %= DUP_CACHE_SIZE;
    if (dup_cache[idx] == sum)
    { freq_dups++; 
    }
    else
    { dup_cache[idx] = sum; 
      for (k = 0; k < NUM_HASHES_PER_CHAR / GROUP_BITS; k++)
      { count[ofs * GROUP_COUNTERS / GROUP_BITS + (sum % GROUP_COUNTERS)]++;
        ofs += GROUP_BITS;
        sum >>= GROUP_BITS;
  } } }

  /* Distribute the occurrences of each bit group over the frequency table. */
  for (ofs = 0; ofs < MD_BITS; ofs += GROUP_BITS)
  { int j;
    for (j = 0; j < GROUP_COUNTERS; j++)
    { int k;
      for (k = 0; k < GROUP_BITS; k++)
      { freq[ofs + k] += ((1<<k) & j) 
          ? count[ofs * GROUP_COUNTERS / GROUP_BITS + j]
          : -count[ofs * GROUP_COUNTERS / GROUP_BITS + j];
  } } }
      
  { int j;
    int num = MD_BITS;
    int stat_warn = 0;
    double sum = 0.0;
    double sumsqr = 0.0;
    double average, variance, stddev, bits, exp_average, max_average;

    assert (num >= 2);

    sum = 0;

    for (j = 0; j < num; j++)
    { double f = abs ((double) freq[j]);
      sum += f;
      sumsqr += f*f;
    }

    variance = (sumsqr - (sum * sum / num)) / (num - 1);
    average = sum / num;
    stddev = sqrt (variance);
    bits = (NUM_HASHES_PER_CHAR * (file[file_count].length - freq_dups)) 
             / (8 * MD_LENGTH);
    /* Random files, or short files with few repetitions should have
       average very close to the expected average. Large deviations
       show there is too much redundancy, or there is another problem
       with the statistical fundamentals of the algorithm. */
    exp_average = sqrt (2 * bits / pi);
    max_average = 2.0 * pow (2 * bits / pi, 0.6);

    stat_warn = flag_warning
      && (average < exp_average * 0.5 || average > max_average);
    if (stat_warn)
    { fprintf (stdout, "%s: warning: "
               "too much redundancy, fingerprint may not be accurate\n",
               file[file_count].name);
      
    }

    if (flag_verbose > 1 || (flag_verbose && stat_warn))
    { printf 
        ("%i frequencies, average %5.1f, std dev %5.1f, %2.1f %% duplicates, "
         "\"%s\"\n",
         num, average, stddev,
         100.0 * freq_dups / (double) file[file_count].length,
         file[file_count].name);
      printf
        ("%1.0f expected bits per frequency, "
         "expected average %1.1f, max average %1.1f\n",
         bits, exp_average, max_average);
  } }

  if (md)
  { rabin_reset();
    freq_to_md (md);
    if (flag_relative)
    { int d = dist (md, relative_md);
      double sim = 1.0 - MIN (1.0, (double) (d) / (MD_LENGTH * 4 - 1));
      fprintf (stdout, "%s %llu %u %s %u %3.1f\n", 
               md_to_str (md), (long long unsigned) 0, len, name, 
               d, 100.0 * sim);
    }
    else
    {
      fprintf (stdout, "%s %llu %u %s\n", 
               md_to_str (md), (long long unsigned) 0, len, name);
} } }

void process_file (char *name)
{ int fd;
  struct stat fs;
  u_char *data;
  File *fi = file+file_count;;

  fd = open (name, O_RDONLY, 0);
  if (fd < 0) 
  { perror (name);
    exit (2);
  }

  if (fstat (fd, &fs))
  { perror (name);
    exit (2);
  }

  if (fs.st_size >= MIN_FILE_SIZE
      && fs.st_size <= MAX_FILE_SIZE)
  { fi->length = fs.st_size;
    fi->name = name;

    data = (u_char *) mmap (0, fs.st_size, PROT_READ, MAP_PRIVATE, fd, 0);

    if (data == (u_char *) -1)
    { perror (name);
      exit (2);
    }

    process_data (name, data, fs.st_size, fi->md);
    munmap (data, fs.st_size);
    file_bytes += fs.st_size;
    file_count++;
  } else if (flag_verbose) 
  { fprintf (stdout, "skipping %s (size %llu)\n", name, fs.st_size); }

  close (fd);
}

int main (int argc, char *argv[])
{ int ch, j;

  strncpy (cmd, basename (argv[0]), 8);
  msgout = stdout;

  while ((ch = getopt(argc, argv, "dhr:vw")) != -1)
  { switch (ch) 
    { case 'd': flag_debug++;
		break;
      case 'r': if (!optarg)
                { fprintf (stderr, "%s: missing argument for -r\n", cmd);
                  return 1;
                }
                if (str_to_md (optarg, relative_md)) flag_relative = optarg;
                else
                { fprintf (stderr, "%s: not a valid fingerprint\n", optarg);
                  return 1;
                }
                break;
      case 'v': flag_verbose++;
                break;
      case 'w': flag_warning++;
                break;
      default : usage();
                return (ch != 'h');
  } }

  argc -= optind;
  argv += optind;

  if (argc == 0) usage();

  rabin_reset ();
  if (flag_verbose && flag_relative)
  { fprintf (stdout, "distances are relative to %s\n", flag_relative);
  }

  file = (File *) calloc (argc, sizeof (File));

  for (j = 0; j < argc; j++) process_file (argv[j]);

  if (flag_verbose) 
  { fprintf (stdout, "%li bytes in %i files\n", file_bytes, file_count);
  }

  return 0;
}

--Apple-Mail-5-693823301
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="rabinpoly.c"
Content-Disposition: attachment;
	filename=rabinpoly.c

/*
 *
 * Copyright (C) 1999 David Mazieres (dm@uun.org)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 * USA
 *
 */

  /* Faster generic_fls */
  /* (c) 2002, D.Phillips and Sistina Software */

#include "rabinpoly.h"
#define MSB64 0x8000000000000000ULL

static inline unsigned fls8(unsigned n)
{
       return n & 0xf0?
           n & 0xc0? (n >> 7) + 7: (n >> 5) + 5:
           n & 0x0c? (n >> 3) + 3: n - ((n + 1) >> 2);
}

static inline unsigned fls16(unsigned n)
{
       return n & 0xff00? fls8(n >> 8) + 8: fls8(n);
}

static inline unsigned fls32(unsigned n)
{
       return n & 0xffff0000? fls16(n >> 16) + 16: fls16(n);
}

static inline unsigned fls64(unsigned long long n) /* should be u64 */
{
       return n & 0xffffffff00000000ULL? fls32(n >> 32) + 32: fls32(n);
}


static u_int64_t polymod (u_int64_t nh, u_int64_t nl, u_int64_t d);
static void      polymult (u_int64_t *php, u_int64_t *plp,
                           u_int64_t x, u_int64_t y);
static u_int64_t polymmult (u_int64_t x, u_int64_t y, u_int64_t d);

static u_int64_t poly = 0xb15e234bd3792f63ull;	// Actual polynomial
static u_int64_t T[256];			// Lookup table for mod
static int shift;

u_int64_t append8 (u_int64_t p, u_char m) 
{ return ((p << 8) | m) ^ T[p >> shift]; 
}

static u_int64_t
polymod (u_int64_t nh, u_int64_t nl, u_int64_t d)
{ assert (d);
  int i;
  int k = fls64 (d) - 1;
  d <<= 63 - k;

  if (nh) {
    if (nh & MSB64)
      nh ^= d;
    for (i = 62; i >= 0; i--)
      if (nh & 1ULL << i) {
	nh ^= d >> (63 - i);
	nl ^= d << (i + 1);
      }
  }
  for (i = 63; i >= k; i--)
    if (nl & 1ULL << i)
      nl ^= d >> (63 - i);
  return nl;
}

static void
polymult (u_int64_t *php, u_int64_t *plp, u_int64_t x, u_int64_t y)
{ int i;
  u_int64_t ph = 0, pl = 0;
  if (x & 1)
    pl = y;
  for (i = 1; i < 64; i++)
    if (x & (1ULL << i)) {
      ph ^= y >> (64 - i);
      pl ^= y << i;
    }
  if (php)
    *php = ph;
  if (plp)
    *plp = pl;
}

static u_int64_t
polymmult (u_int64_t x, u_int64_t y, u_int64_t d)
{
  u_int64_t h, l;
  polymult (&h, &l, x, y);
  return polymod (h, l, d);
}

static int size = RABIN_WINDOW_SIZE;
static u_int64_t fingerprint = 0;
static int bufpos = -1;
static u_int64_t U[256];
static u_char buf[RABIN_WINDOW_SIZE];

void rabin_init ()
{ assert (poly >= 0x100);
  u_int64_t sizeshift = 1;
  int xshift = fls64 (poly) - 1;
  int i, j;
  shift = xshift - 8;
  u_int64_t T1 = polymod (0, 1ULL << xshift, poly);
  for (j = 0; j < 256; j++)
    T[j] = polymmult (j, T1, poly) | ((u_int64_t) j << xshift);

  for (i = 1; i < size; i++)
    sizeshift = append8 (sizeshift, 0);
  for (i = 0; i < 256; i++)
    U[i] = polymmult (i, sizeshift, poly);
  bzero (buf, sizeof (buf));
}

void
rabin_reset ()
{ rabin_init();
  fingerprint = 0; 
  bzero (buf, sizeof (buf));
}

u_int64_t
rabin_slide8 (u_char m)
{ u_char om;
  if (++bufpos >= size) bufpos = 0;

  om = buf[bufpos];
  buf[bufpos] = m;
  fingerprint = append8 (fingerprint ^ U[om], m);

  return fingerprint;
}
  

--Apple-Mail-5-693823301
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="rabinpoly.h"
Content-Disposition: attachment;
	filename=rabinpoly.h

/*
 *
 * Copyright (C) 2000 David Mazieres (dm@uun.org)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
 * USA
 *
 * Translated to C and simplified by Geert Bosch (bosch@gnat.com)
 */

#include <assert.h>
#include <strings.h>
#include <sys/types.h>

#ifndef RABIN_WINDOW_SIZE
#define RABIN_WINDOW_SIZE 48
#endif
void rabin_reset(); 
u_int64_t rabin_slide8(u_char c); 

--Apple-Mail-5-693823301--
