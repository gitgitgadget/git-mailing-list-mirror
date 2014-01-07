From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs
 is false
Date: Tue, 7 Jan 2014 13:45:22 +0700
Message-ID: <CACsJy8CBCb1i3iLevmgR2SZYpFyZGDPqDSKEL4B_78JyE9Mhew@mail.gmail.com>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Brodie Rao <brodie@sf.io>
X-From: git-owner@vger.kernel.org Tue Jan 07 07:45:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0QQI-0006RA-1B
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 07:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbaAGGpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 01:45:54 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:35847 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbaAGGpx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 01:45:53 -0500
Received: by mail-qa0-f42.google.com with SMTP id ii20so270900qab.15
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 22:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iQbaFMj/fVKeqif0/1FCaKJ1RSi/vDwpP1xwCcgc7KY=;
        b=oEJFDX+RuFBvaf/dYH+14zwlm+zy1JPwslOl3GgUhMPuO0fOT99NYqNkg2a3gZfpDx
         FJR/czods2IGTGpq1qW9N7Fk5vMWf6E1dcIHZ9WgbUJsMRU16nybV4roHk0Vx3cFssFj
         WeuETlTu1V7r8HTiGhTV1qpWwUW9rvWst6kWf0Hl1pRdlKMCLX/gWWxya24wTSlxcgpV
         EE590/0rG+FCazaeqq2nsj0VlckfGiI9HGvfEsFMLBz5f/zeYbGWToKQIRMkR3ANBs8k
         e9iH/bNfP/12qLIddWnAY1LvQFFBMq2mI+Hx27FfJIEZwBAlWzec0Na0Pfe1ZauUorh5
         MScA==
X-Received: by 10.49.81.206 with SMTP id c14mr190724232qey.79.1389077152850;
 Mon, 06 Jan 2014 22:45:52 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Mon, 6 Jan 2014 22:45:22 -0800 (PST)
In-Reply-To: <1389065521-46331-1-git-send-email-brodie@sf.io>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240099>

On Tue, Jan 7, 2014 at 10:32 AM, Brodie Rao <brodie@sf.io> wrote:
> This change ensures get_sha1_basic() doesn't try to resolve full hashes
> as refs when ambiguous ref warnings are disabled.
>
> This provides a substantial performance improvement when passing many
> hashes to a command (like "git rev-list --stdin") when
> core.warnambiguousrefs is false. The check incurs 6 stat()s for every
> hash supplied, which can be costly over NFS.
> ---
>  sha1_name.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index e9c2999..10bd007 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -451,9 +451,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         int at, reflog_len, nth_prior = 0;
>
>         if (len == 40 && !get_sha1_hex(str, sha1)) {
> -               if (warn_on_object_refname_ambiguity) {
> +               if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
>                         refs_found = dwim_ref(str, len, tmp_sha1, &real_ref);
> -                       if (refs_found > 0 && warn_ambiguous_refs) {
> +                       if (refs_found > 0) {
>                                 warning(warn_msg, len, str);
>                                 if (advice_object_name_warning)
>                                         fprintf(stderr, "%s\n", _(object_name_msg));

Looks obviously correct. Thanks.
-- 
Duy
