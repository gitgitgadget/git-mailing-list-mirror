From: Tony Wang <wwwjfy@gmail.com>
Subject: Re: [PATCH] Copy resolve_ref() return value for longer use
Date: Sat, 10 Dec 2011 11:43:24 +0800
Message-ID: <626C086D699644D181B9FA573EDFFCA6@gmail.com>
References: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
 <1320719428-1802-1-git-send-email-pclouds@gmail.com>
 <7vehxcpns5.fsf@alter.siamese.dyndns.org>
 <CACsJy8ARAzNWjZfXwnNG0AprCFXLCkiDrE+eFj9icbeNX14xKw@mail.gmail.com>
 <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 04:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZDx6-0002Qi-1U
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 04:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab1LJDng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 22:43:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab1LJDnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 22:43:35 -0500
Received: by iakc1 with SMTP id c1so5189286iak.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 19:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=MrfEXxuFIqcq19rfWMR2ByrFJsKBC84RIEIOnQtfDPA=;
        b=NFyKvpnILx38AasHxldzQorzGlWRJwoX+cH4PXkFFsZcc5rpwpAJ4qrmwbtRsUsoHY
         6YRIEbvEa4a7h4LSCb82D+GZpYyZAIxp2CeLdR5EuemLmrLiJSxQ+p6+SAPjewjvI+UL
         ms30JXJqFjfUcBh2NuEMbLCMJq/3vW7j4aojg=
Received: by 10.42.172.70 with SMTP id m6mr4876234icz.37.1323488614938;
        Fri, 09 Dec 2011 19:43:34 -0800 (PST)
Received: from localhost (wwwjfy.net. [68.68.99.210])
        by mx.google.com with ESMTPS id wo4sm21752526igc.5.2011.12.09.19.43.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 19:43:32 -0800 (PST)
In-Reply-To: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
X-Mailer: sparrow 1.5beta1 (build 1034)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186720>

Hi, 

I don't know about the procedure, but wonder is any one following this? 

-- 
BR,
Tony Wang


On Sunday, November 13, 2011 at 15:59, Junio C Hamano wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com (mailto:pclouds@gmail.com)> writes:
> 
> > I went through all of them. Most of them only checks if return value
> > is NULL, or does one-time string comparison. Others do xstrdup() to
> > save the return value. Will update the patch message to reflect this.
> 
> 
> 
> Thanks. Given your analysis, I think the potential change I alluded to to
> return allocated memory from the function is probably overkill in the
> current state of the code.
> 
> But as the codepaths around the existing callsites evolve, some of these
> call sites that are not problematic in today's code can become problematic
> if we are not careful. I was primarily wondering if an updated API could
> force us to be careful when making future changes.
> 
> And a change along the lines of your suggestion
> 
> > ... Though if you don't mind a bigger patch, we could turn
> > 
> > const char *resolve_ref(const char *path, const char *sha1, int
> > reading, int *flag);
> > 
> > to
> > 
> > int resolve_ref(const char *path, const char *sha1, int reading, int
> > *flag, char **ref);
> > 
> > where *ref is the current return value and is only allocated by
> > resolve_ref() if ref != NULL.
> 
> 
> 
> might be one such updated API that makes mistakes harder to make. I dunno.
> 
> But if we were to go that route, as the first step, it might make sense to
> rewrite "only checks if it returns NULL and uses sha1" callers to call
> either read_ref() or ref_exists(), so that we do not have to worry about
> leaking at such callers when we later decide to return allocated memory
> from resolve_ref().
> 
> 
> builtin/branch.c | 3 +--
> builtin/merge.c | 4 ++--
> 2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 51ca6a0..94948a4 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -565,7 +565,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
> static void rename_branch(const char *oldname, const char *newname, int force)
> {
> struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
> - unsigned char sha1[20];
> struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
> int recovery = 0;
> 
> @@ -577,7 +576,7 @@ static void rename_branch(const char *oldname, const char *newname, int force)
> * Bad name --- this could be an attempt to rename a
> * ref that we used to allow to be created by accident.
> */
> - if (resolve_ref(oldref.buf, sha1, 1, NULL))
> + if (ref_exists(oldref.buf))
> recovery = 1;
> else
> die(_("Invalid branch name: '%s'"), oldname);
> diff --git a/builtin/merge.c b/builtin/merge.c
> index dffd5ec..42b4f9e 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -420,7 +420,7 @@ static struct object *want_commit(const char *name)
> static void merge_name(const char *remote, struct strbuf *msg)
> {
> struct object *remote_head;
> - unsigned char branch_head[20], buf_sha[20];
> + unsigned char branch_head[20];
> struct strbuf buf = STRBUF_INIT;
> struct strbuf bname = STRBUF_INIT;
> const char *ptr;
> @@ -479,7 +479,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
> strbuf_addstr(&truname, "refs/heads/");
> strbuf_addstr(&truname, remote);
> strbuf_setlen(&truname, truname.len - len);
> - if (resolve_ref(truname.buf, buf_sha, 1, NULL)) {
> + if (ref_exists(truname.buf)) {
> strbuf_addf(msg,
> "%s\t\tbranch '%s'%s of .\n",
> sha1_to_hex(remote_head->sha1),
