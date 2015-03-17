From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Tue, 17 Mar 2015 17:00:02 +0100
Message-ID: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:00:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXtv8-00015M-Ag
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 17:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbbCQQA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 12:00:29 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58119 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753996AbbCQQA1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2015 12:00:27 -0400
X-AuditID: 1207440c-f79376d00000680a-c3-55084f976b06
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.1F.26634.79F48055; Tue, 17 Mar 2015 12:00:23 -0400 (EDT)
Received: from michael.fritz.box (p4FC96AAE.dip0.t-ipconnect.de [79.201.106.174])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2HG0LSb023811
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 17 Mar 2015 12:00:22 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqDvdnyPU4PthQ4uuK91MFg29V5gt
	bq+Yz2zx+NYEJgcWj7/vPzB5zL1v6XHxkrLH501yASxR3DZJiSVlwZnpefp2CdwZe/vamQuO
	uVUsX7KdpYHxgWkXIyeHhICJxONZN5kgbDGJC/fWs3UxcnEICVxmlFiwcR2Uc5JJYnv/bVaQ
	KjYBXYlFPc1gHSICahIT2w6xgNjMAikSnX/usIPYwgKBEotm3gWrYRFQlXjwexIziM0r4Czx
	fNlURohtchLnj/9knsDIvYCRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZG
	SDjw7GD8tk7mEKMAB6MSD++NAvZQIdbEsuLK3EOMkhxMSqK8eR4coUJ8SfkplRmJxRnxRaU5
	qcWHGCU4mJVEeO+4A+V4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	y/2AGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBoR5fDAx2kBQP0N4KkHbe4oLE
	XKAoROspRkUpcd75IAkBkERGaR7cWFiUv2IUB/pSmFcZpIoHmCDgul8BDWYCGtzSzgYyuCQR
	ISXVwOiZL38qKWbuyVLBV0pdEuKPGmxWbM8Vi1S8qM53a9OH94/cz57j0v0v6JDYdGuL3fSq
	x84PVP2f8Z83Fpx0ZbrTrr4fBo5Hf22pUxERebZ1guL2MBWrkJIvt4Iyvun+iHz87vvqOz1W
	K4ymXdw7kX3ehwxei6+1HF+017y52fz77Jv13OdnJeQqsRRnJBpqMRcVJwIAdzLZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265635>

Sorry for the long email. Feel free to skip over the background info
and continue reading at "My solution" below.

This odyssey started with a typo:

    $ git shortlog -snl v2.2.0..v2.3.0
     14795      Junio C Hamano
      1658      Jeff King
      1400      Shawn O. Pearce
      1109      Linus Torvalds
       760      Jonathan Nieder
    [...]

It took me a minute to realize why so many commits are listed. It
turns out that "-l", which I added by accident, requires an integer
argument, but it happily swallows "v2.2.0..v2.3.0" without error. This
leaves no range argument, so the command traverses the entire history
of HEAD.

The relevant code is

        else if ((argcount = short_opt('l', av, &optarg))) {
                options->rename_limit = strtoul(optarg, NULL, 10);
                return argcount;
        }

, which is broken in many ways. First of all, strtoul() is way too
permissive for simple tasks like this:

* It allows leading whitespace.

* It allows arbitrary trailing characters.

* It allows a leading sign character ('+' or '-'), even though the
  result is unsigned.

* If the string doesn't contain a number at all, it sets its "endptr"
  argument to point at the start of the string but doesn't set errno.

* If the value is larger than fits in an unsigned long, it returns the
  value clamped to the range 0..ULONG_MAX (setting errno to ERANGE).

* If the value is between -ULONG_MAX and 0, it returns the positive
  integer with the same bit pattern, without setting errno(!) (I can
  hardly think of a scenario where this would be useful.)

* For base=0 (autodetect base), it allows a base specifier prefix "0x"
  or "0" and parses the number accordingly. For base=16 it also allows
  a "0x" prefix.

strtol() has similar foibles.

The caller compounds the permissivity of strtoul() with further sins:

* It does absolutely no error detection.

* It assigns the return value, which is an unsigned long, to an int
  value. This could truncate the result, perhaps even resulting in
  rename_limit being set to a negative value.

When I looked around, I found scores of sites that call atoi(),
strtoul(), and strtol() carelessly. And it's understandable. Calling
any of these functions safely is so much work as to be completely
impractical in day-to-day code.

git-compat-util.h has two functions, strtoul_ui() and strtol_i(), that
try to make parsing integers a little bit easier. But they are only
used in a few places, they hardly restrict the pathological
flexibility of strtoul()/strtol(), strtoul_ui() doesn't implement
clamping consistently when converting from unsigned long to unsigned
int, and neither function can be used when the integer value *is*
followed by other characters.


My solution: the numparse module

So I hereby propose a new module, numparse, to make it easier to parse
integral values from strings in a convenient, safe, and flexible way.
The first commit introduces the new module, and subsequent commits
change a sample (a small fraction!) of call sites to use the new
functions. Consider it a proof-of-concept. If people are OK with this
approach, I will continue sending patches to fix other call sites. (I
already have another two dozen such patches in my repo).

Please see the docstrings in numparse.h in the first commit for
detailed API docs. Briefly, there are eight new functions:

    parse_{l,ul,i,ui}(const char *s, unsigned int flags,
                      T *result, char **endptr);
    convert_{l,ul,i,ui}(const char *s, unsigned int flags, T *result);

The parse_*() functions are for parsing a number from the start of a
string; the convert_*() functions are for parsing a string that
consists of a single number. The flags argument selects not only the
base of the number, but also which of strtol()/strtoul()'s many
features should be allowed. The *_i() and *.ui() functions are for
parsing int and unsigned int values; they are careful about how they
truncate the corresponding long values. The functions all return 0 on
success and a negative number on error.

Here are a few examples of how these functions can be used (taken from
the header of numparse.h):

* Convert hexadecimal string s into an unsigned int. Die if there are
  any characters in s besides hexadecimal digits, or if the result
  exceeds the range of an unsigned int:

    if (convert_ui(s, 16, &result))
            die("...");

* Read a base-ten long number from the front of a string, allowing
  sign characters and setting endptr to point at any trailing
  characters:

    if (parse_l(s, 10 | NUM_SIGN | NUM_TRAILING, &result, &endptr))
            die("...");

* Convert decimal string s into a signed int, but not allowing the
  string to contain a '+' or '-' prefix (and thereby indirectly
  ensuring that the result will be non-negative):

    if (convert_i(s, 10, &result))
            die("...");

* Convert s into a signed int, interpreting prefix "0x" to mean
  hexadecimal and "0" to mean octal. If the value doesn't fit in an
  unsigned int, set result to INT_MIN or INT_MAX.

    if (convert_i(s, NUM_SLOPPY, &result))
            die("...");

My main questions:

* Do people like the API? My main goal was to make these functions as
  painless as possible to use correctly, because there are so many
  call sites.

* Is it too gimmicky to encode the base together with other options in
  `flags`? (I think it is worth it to avoid the need for another
  parameter, which callers could easily put in the wrong order.)

* Am I making callers too strict? In many cases where a positive
  integer is expected (e.g., "--abbrev=<num>"), I have been replacing
  code like

      result = strtoul(s, NULL, 10);

  with

      if (convert_i(s, 10, &result))
              die("...");

  Strictly speaking, this is backwards incompatible, because the
  former allows things like

      --abbrev="+10"
      --abbrev="    10"
      --abbrev="10 bananas"
      --abbrev=-18446744073709551606

  (all equivalent to "--abbrev=10"), whereas the new code rejects all
  of them. It would be easy to change the new code to allow the first
  three, by adding flags NUM_PLUS, NUM_LEADING_WHITESPACE, or
  NUM_TRAILING respectively. But my inclination is to be strict
  (though I could easily be persuaded to permit the first one).

* Should I submit tiny patches, each rewriting a single call site, or
  make changes in larger chunks (say, file by file)? For example, in
  revision.c there is a function handle_revision_opt() that contains
  about 10 call sites that should be rewritten, for 10 different
  options that take integers. My gut feeling is that the rewrite of
  "--min-age=<value>" should be done in a different patch than that of
  "--min-parents=<value>", especially since the invocations might use
  different levels of parsing strictness that might be topics of
  discussion on the ML. On the other hand, I feel silly bombarding the
  list with tons of tiny patches.

* I couldn't think of any places where today's sloppy parsing could
  result in security vulnerabilities, but people should think about
  this, too. I would be especially wary of sites that call strtoul()
  and assign the result to an int, seemingly not considering that the
  result could end up negative.

These patches apply to "master". They are also available on my GitHub
repo [1].

Michael

[1] https://github.com/mhagger/git.git, branch "numparse1"

Michael Haggerty (14):
  numparse: new module for parsing integral numbers
  cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
  write_subdirectory(): use convert_ui() for parsing mode
  handle_revision_opt(): use skip_prefix() in many places
  handle_revision_opt(): use convert_i() when handling "-<digit>"
  strtoul_ui(), strtol_i(): remove functions
  handle_revision_opt(): use convert_ui() when handling "--abbrev="
  builtin_diff(): detect errors when parsing --unified argument
  opt_arg(): val is always non-NULL
  opt_arg(): use convert_i() in implementation
  opt_arg(): report errors parsing option values
  opt_arg(): simplify pointer handling
  diff_opt_parse(): use convert_i() when handling "-l<num>"
  diff_opt_parse(): use convert_i() when handling --abbrev=<num>

 Makefile                                  |   1 +
 builtin/update-index.c                    |   3 +-
 contrib/convert-objects/convert-objects.c |   3 +-
 diff.c                                    |  55 ++++----
 git-compat-util.h                         |  26 ----
 numparse.c                                | 180 ++++++++++++++++++++++++++
 numparse.h                                | 207 ++++++++++++++++++++++++++++++
 revision.c                                |  64 ++++-----
 8 files changed, 447 insertions(+), 92 deletions(-)
 create mode 100644 numparse.c
 create mode 100644 numparse.h

-- 
2.1.4
