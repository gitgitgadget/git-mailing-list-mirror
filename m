From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-apply: prevent non-explicit permission
 changes
Date: Thu, 01 Jan 2009 16:56:11 -0800
Message-ID: <7v3ag2frv8.fsf@gitster.siamese.dyndns.org>
References: <20081230235357.GA12747@myhost>
 <7vfxk3npuc.fsf@gitster.siamese.dyndns.org> <20090101221720.GA5603@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 01:58:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIYMP-0003V6-2X
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 01:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbZABA40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 19:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbZABA4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 19:56:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbZABA4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 19:56:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DB54D1B8FD;
	Thu,  1 Jan 2009 19:56:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9497C1B8F9; Thu, 
 1 Jan 2009 19:56:13 -0500 (EST)
In-Reply-To: <20090101221720.GA5603@myhost> (Alexander Potashev's message of
 "Fri, 2 Jan 2009 01:17:20 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C16746A-D868-11DD-96E7-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104352>

Alexander Potashev <aspotashev@gmail.com> writes:

> On 05:00 Thu 01 Jan     , Junio C Hamano wrote:
>> Alexander Potashev <aspotashev@gmail.com> writes:
> ...
>> > @@ -2447,6 +2447,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
>> >  	if (st_mode != patch->old_mode)
>> >  		fprintf(stderr, "warning: %s has type %o, expected %o\n",
>> >  			old_name, st_mode, patch->old_mode);
>> > +	patch->new_mode = st_mode;
>> 
>> Can you do this unconditionally, overwriting whatever we read from the
>> patch header metainfo lines?
>
> Do you mean overwriting of 'patch->new_mode' right after patch parsing?

My question was if we should assign st_mode to new_mode _unconditionally_
here, even when patch->new_mode has already been read from the explicit
mode change line (i.e. "new mode ", line not "index "line) of the patch
input.

The call-chain of the program looks like this:

-> apply_patch()
   -> parse_chunk()
      -> find_header()
         * initialize new_mode and old_mode to 0
         -> parse_git_header()
            * set new_mode and old_mode from the patch metainfo, i.e.
              "new mode", "old mode" and "index" lines.
      -> parse_single_patch()
   -> check_patch_list()
      -> check_patch()
         -> check_preimage()
            * make sure there is no local mods
            * warn if old_mode read from the patch (i.e. the preimage file
              the patch submitter used to prepare the patch against) does not
              match what we have
         * warn about mode inconsistency (e.g. the patch submitter thinks
           the mode should be 0644 but our tree has 0755).
         -> apply_data()
   -> write_out_results()
      -> write_out_one_result(0)
         * delete old
      -> write_out_one_result(1)
         * create new

Currently the mode 100644 on the "index" line in a patch is handled
exactly in the same way as having "old mode 100644" and "new mode 100644"
lines in the metainfo.  The patch submitter claims to have started from
100644 and he claims that he wants to have 100644 as the result.  That is
why there is a warning in check_patch().

If we stop reading the new mode from the "index" line (but we still read
"old_mode" there) without any other change you made in your patch, what
breaks (i.e. without the patch->new_mode assignment hunk)?  I haven't
followed the codepath too closely, and I suspect you found some cases
where new_mode stays 0 as initialized, and that may be the reason you have
this assignment.

But the assignment being unconditional bothered me a lot.

I tend to agree that the current "The final mode bits I want to have on
this path is this" semantics we give to the "index" line is much less
useful and less sane and it is a good idea to redefine it as "FYI, the
copy I made this patch against had this mode bits.  I do not intend to
change the mode bits of the path with this patch."

 builtin-apply.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git c/builtin-apply.c w/builtin-apply.c
index 07244b0..a8f75ed 100644
--- c/builtin-apply.c
+++ w/builtin-apply.c
@@ -630,7 +630,7 @@ static int gitdiff_index(const char *line, struct patch *patch)
 	memcpy(patch->new_sha1_prefix, line, len);
 	patch->new_sha1_prefix[len] = 0;
 	if (*ptr == ' ')
-		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
+		patch->old_mode = strtoul(ptr+1, NULL, 8);
 	return 0;
 }
 
@@ -2447,6 +2447,8 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
 	if (st_mode != patch->old_mode)
 		fprintf(stderr, "warning: %s has type %o, expected %o\n",
 			old_name, st_mode, patch->old_mode);
+	if (!patch->new_mode)
+		patch->new_mode = st_mode;
 	return 0;
 
  is_new:
