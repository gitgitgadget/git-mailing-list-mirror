From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] patch-id: make it stable against hunk reordering
Date: Sun, 30 Mar 2014 13:52:02 +0300
Message-ID: <20140330105202.GA24476@redhat.com>
References: <1396009159-2078-1-git-send-email-mst@redhat.com>
 <xmqqha6i9lle.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 30 12:52:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUDLq-0000L3-RH
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 12:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaC3Kvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 06:51:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62565 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbaC3Kvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 06:51:54 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2UApdBC007025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 30 Mar 2014 06:51:40 -0400
Received: from redhat.com (vpn1-7-238.ams2.redhat.com [10.36.7.238])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2UApYPK009532;
	Sun, 30 Mar 2014 06:51:37 -0400
Content-Disposition: inline
In-Reply-To: <xmqqha6i9lle.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245458>

On Fri, Mar 28, 2014 at 12:20:13PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Patch id changes if you reorder hunks in a diff.
> > As the result is functionally equivalent, this is surprising to many
> > people.
> > In particular, reordering hunks is helpful to make patches
> > more readable (e.g. API header diff before implementation diff).
> > In git, it is often done e.g. using the "-O <orderfile>" option,
> > so supporting it better has value.
> >
> > Hunks within file can be reordered manually provided
> > the same pathname can appear more than once in the input.
> >
> > Change patch-id behaviour making it stable against
> > hunk reodering:
> > 	- prepend header to each hunk (if not there)
> > 		Note: POSIX requires patch to be robust against hunk reordering
> > 		provided each diff hunk has a header:
> > 		http://pubs.opengroup.org/onlinepubs/7908799/xcu/patch.html
> > 		If the patch file contains more than one patch, patch will attempt to
> > 		apply each of them as if they came from separate patch files. (In this
> > 		case the name of the patch file must be determinable for each diff
> > 		listing.)
> >
> > 	- calculate SHA1 hash for each hunk separately
> > 	- sum all hashes to get patch id
> >
> > Add a new flag --unstable to get the historical behaviour.
> >
> > Add --stable which is a nop, for symmetry.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> > Changes from v1: documented motivation for supporting
> > hunk reordering (and not just file reordering).
> > No code changes.
> >
> > Junio, you didn't respond so I'm not sure whether I convinced
> > you that supporting hunk reordering within file has value.
> > So I kept this functionality around for now, if
> > you think I should drop this, please let me know explicitly.
> > Thanks, and sorry about being dense!
> 
> The motivation I read from the exchange was that:
> 
>  (1) we definitely want to support a mode that is stable with use of
>      "diff -O" (i.e. reordering patches per paths);
> 
>  (2) supporting a patch with swapped "hunks" does not have any
>      practical value.  When you have a patch to the same file F with
>      two hunks starting at lines 20 and 40, manually reordering
>      hunks to create a patch that shows the hunk that starts at line
>      40 and then the other hunk that starts at line 20 is not a
>      useful exercise;

I agree, especially since the resulting patch can't be applied with
either patch or git apply.

>  (3) but supporting a patch that touches the same path more than
>      once is in line with what "patch" and "git apply" after
>      7a07841c (git-apply: handle a patch that touches the same path
>      more than once better, 2008-06-27) do.
> 
> In other words, the goal of this change would be to give the same id
> for all these three:
> 
>     (A) straight-forward:
> 
>         diff --git a/foo.c b/foo.c
>         --- a/foo.c
>         +++ b/foo.c
>         @@ -20,1 +20,1 @@
> 
>         -foo
>         +bar
> 
>         @@ -40,1 +40,1 @@
> 
>         -frotz
>         +xyzzy
> 
>     (B) as two patches concatenated together:
> 
>         diff --git a/foo.c b/foo.c
>         --- a/foo.c
>         +++ b/foo.c
>         @@ -20,1 +20,1 @@
> 
>         -foo
>         +bar
> 
>         diff --git a/foo.c b/foo.c
>         --- a/foo.c
>         +++ b/foo.c
>         @@ -40,1 +40,1 @@
> 
>         -frotz
>         +xyzzy
> 
>     (C) the same as (B) but with a swapped order:
> 
>         diff --git a/foo.c b/foo.c
>         --- a/foo.c
>         +++ b/foo.c
>         @@ -40,1 +40,1 @@
> 
>         -frotz
>         +xyzzy
>         diff --git a/foo.c b/foo.c
>         --- a/foo.c
>         +++ b/foo.c
>         @@ -20,1 +20,1 @@
> 
>         -foo
>         +bar
> 
> Am I reading you correctly?

Absolutely.

> If that is the case, I think I can buy such a change.  It appears to
> me that in addition to changing the way the bytes form multiple
> hunks are hashed, it would need to hash the file-level headers
> together with each hunk when processing input (A) in order to make
> the output consistent with the output for the latter two.

Exactly. This is what this change attempts to do:
+                                   if (hunks) {
+                                           flush_one_hunk(result, &ctx);
+                                           memcpy(&ctx, &header_ctx,
+                                                  sizeof ctx);
+                                   } else {
+                                           /* Save ctx for next hunk.  */
+                                           memcpy(&header_ctx, &ctx,
+                                                  sizeof ctx);
+                                   }

I'll add more code comments to clarify the logic here.

> Alternatively, you could hash the header for the same path only once
> when processing input like (B) or (C) and mix.  That would also give
> you the same result as processing (A) in a straight-forward way.


Yes, that is also possible.
I think I slightly prefer the former way because this
variant gives the same result for
         diff --git a/foo.c b/foo.c
         --- a/foo.c
         +++ b/foo.c
         @@ -20,2 +20,3 @@
 
         +bar
 
         diff --git a/bar.c b/bar.c
         --- a/bar.c
         +++ b/bar.c
         @@ -40,2 +40,3 @@
 
         +foo

and
         diff --git a/bar.c b/bar.c
         --- a/bar.c
         +++ b/bar.c
         @@ -20,2 +20,3 @@
 
         +foo
 
         diff --git a/foo.c b/foo.c
         --- a/foo.c
         +++ b/foo.c
         @@ -40,2 +40,3 @@
 
         +bar


but if you disagree, pls let me know - it's not
a strong preference.

> >  builtin/patch-id.c | 71 ++++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 55 insertions(+), 16 deletions(-)
> >
> > diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> > index 3cfe02d..253ad87 100644
> > --- a/builtin/patch-id.c
> > +++ b/builtin/patch-id.c
> > @@ -1,17 +1,14 @@
> >  #include "builtin.h"
> >  
> > -static void flush_current_id(int patchlen, unsigned char *id, git_SHA_CTX *c)
> > +static void flush_current_id(int patchlen, unsigned char *id, unsigned char *result)
> >  {
> > -	unsigned char result[20];
> >  	char name[50];
> >  
> >  	if (!patchlen)
> >  		return;
> >  
> > -	git_SHA1_Final(result, c);
> >  	memcpy(name, sha1_to_hex(id), 41);
> >  	printf("%s %s\n", sha1_to_hex(result), name);
> > -	git_SHA1_Init(c);
> >  }
> >  
> >  static int remove_space(char *line)
> > @@ -56,10 +53,30 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
> >  	return 1;
> >  }
> >  
> > -static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct strbuf *line_buf)
> > +static void flush_one_hunk(unsigned char *result, git_SHA_CTX *ctx)
> >  {
> > -	int patchlen = 0, found_next = 0;
> > +	unsigned char hash[20];
> > +	unsigned short carry = 0;
> > +	int i;
> > +
> > +	git_SHA1_Final(hash, ctx);
> > +	git_SHA1_Init(ctx);
> > +	/* 20-byte sum, with carry */
> > +	for (i = 0; i < 20; ++i) {
> > +		carry += result[i] + hash[i];
> > +		result[i] = carry;
> > +		carry >>= 8;
> > +	}
> > +}
> > +static int get_one_patchid(unsigned char *next_sha1, unsigned char *result,
> > +			   struct strbuf *line_buf, int stable)
> > +{
> > +	int patchlen = 0, found_next = 0, hunks = 0;
> >  	int before = -1, after = -1;
> > +	git_SHA_CTX ctx, header_ctx;
> > +
> > +	git_SHA1_Init(&ctx);
> > +	hashclr(result);
> >  
> >  	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
> >  		char *line = line_buf->buf;
> > @@ -99,6 +116,18 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
> >  			if (!memcmp(line, "@@ -", 4)) {
> >  				/* Parse next hunk, but ignore line numbers.  */
> >  				scan_hunk_header(line, &before, &after);
> > +				if (stable) {
> > +					if (hunks) {
> > +						flush_one_hunk(result, &ctx);
> > +						memcpy(&ctx, &header_ctx,
> > +						       sizeof ctx);
> > +					} else {
> > +						/* Save ctx for next hunk.  */
> > +						memcpy(&header_ctx, &ctx,
> > +						       sizeof ctx);
> > +					}
> > +				}
> > +				hunks++;
> >  				continue;
> >  			}
> >  
> > @@ -107,7 +136,10 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
> >  				break;
> >  
> >  			/* Else we're parsing another header.  */
> > +			if (stable && hunks)
> > +				flush_one_hunk(result, &ctx);
> >  			before = after = -1;
> > +			hunks = 0;
> >  		}
> >  
> >  		/* If we get here, we're inside a hunk.  */
> > @@ -119,39 +151,46 @@ static int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx, struct st
> >  		/* Compute the sha without whitespace */
> >  		len = remove_space(line);
> >  		patchlen += len;
> > -		git_SHA1_Update(ctx, line, len);
> > +		git_SHA1_Update(&ctx, line, len);
> >  	}
> >  
> >  	if (!found_next)
> >  		hashclr(next_sha1);
> >  
> > +	flush_one_hunk(result, &ctx);
> > +
> >  	return patchlen;
> >  }
> >  
> > -static void generate_id_list(void)
> > +static void generate_id_list(int stable)
> >  {
> > -	unsigned char sha1[20], n[20];
> > -	git_SHA_CTX ctx;
> > +	unsigned char sha1[20], n[20], result[20];
> >  	int patchlen;
> >  	struct strbuf line_buf = STRBUF_INIT;
> >  
> > -	git_SHA1_Init(&ctx);
> >  	hashclr(sha1);
> >  	while (!feof(stdin)) {
> > -		patchlen = get_one_patchid(n, &ctx, &line_buf);
> > -		flush_current_id(patchlen, sha1, &ctx);
> > +		patchlen = get_one_patchid(n, result, &line_buf, stable);
> > +		flush_current_id(patchlen, sha1, result);
> >  		hashcpy(sha1, n);
> >  	}
> >  	strbuf_release(&line_buf);
> >  }
> >  
> > -static const char patch_id_usage[] = "git patch-id < patch";
> > +static const char patch_id_usage[] = "git patch-id [--stable | --unstable] < patch";
> >  
> >  int cmd_patch_id(int argc, const char **argv, const char *prefix)
> >  {
> > -	if (argc != 1)
> > +	int stable;
> > +	if (argc == 2 && !strcmp(argv[1], "--stable"))
> > +		stable = 1;
> > +	else if (argc == 2 && !strcmp(argv[1], "--unstable"))
> > +		stable = 0;
> > +	else if (argc == 1)
> > +		stable = 1;
> > +	else
> >  		usage(patch_id_usage);
> >  
> > -	generate_id_list();
> > +	generate_id_list(stable);
> >  	return 0;
> >  }
