From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH 3/4] Add support for matching full refs in hideRefs
Date: Mon, 02 Nov 2015 06:47:35 +0100
Message-ID: <20151102054735.24971.50757@typhoon.lan>
References: <1446406463-22527-1-git-send-email-lfleischer@lfos.de>
 <1446406463-22527-4-git-send-email-lfleischer@lfos.de>
 <CAPig+cST7sATT4W4Kwp5K=DcuvoFkdgsTDA9iOk=8c_8_GE=-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "Git List" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 06:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zt7y4-0002e9-75
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 06:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbbKBFrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 00:47:39 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:21314 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbbKBFrj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 00:47:39 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id b60bdefd;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Mon, 2 Nov 2015 06:47:36 +0100 (CET)
In-Reply-To: <CAPig+cST7sATT4W4Kwp5K=DcuvoFkdgsTDA9iOk=8c_8_GE=-Q@mail.gmail.com>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280681>

On Sun, 01 Nov 2015 at 21:42:37, Eric Sunshine wrote:
> On Sun, Nov 1, 2015 at 2:34 PM, Lukas Fleischer <lfleischer@lfos.de> wrote:
> > In addition to matching stripped refs, one can now add hideRefs patterns
> > that the full (unstripped) ref is matched against. To distinguish
> > between stripped and full matches, those new patterns must be prefixed
> > with a circumflex (^).
> >
> > This commit also removes support for the undocumented and unintended
> > hideRefs settings "have" (suppressing all "have" lines) and
> > "capabilities^{}" (suppressing the capabilities line).
> >
> > Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> > ---
> > diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> > @@ -1198,7 +1200,15 @@ static void reject_updates_to_hidden(struct command *commands)
> >         struct command *cmd;
> >
> >         for (cmd = commands; cmd; cmd = cmd->next) {
> > -               if (cmd->error_string || !ref_is_hidden(cmd->ref_name))
> 
> Would it make sense to retain the cmd->error_string check here in
> order to avoid doing the extra refname_full construction work below?
> 
>     if (cmd->error_string)
>         continue;
> 
> [...]
> This is leaking refname_full each time through the loop since it never
> gets free()d. If you restructure the code like this, it might be
> easier to avoid leaks:
> 
>     for (cmd = ...; ... ; ...) {
>         if (cmd->error_string)
>             continue;
>         strbuf_addf(&refname_full, "%s%s", ...);
>         if (ref_is_hidden(...)) {
>             if (is_null_sha1(...))
>                 cmd->error_string = "...";
>             else
>                 cmd->error_string = "...";
>         }
>         strbuf_release(&refname_full);
>     }
> 
> As a micro-optimization, you could also pre-populate the strbuf with
> get_git_namespace() outside the loop and remember the length. Then,
> each time through the loop, just append cmd->ref_name, do your
> processing, and, at the bottom of the loop, set the strbuf back to the
> remembered length. (And, you still need to free the strbuf after the
> loop.)
> [...]

Sounds good to me. I changed the code to initialize the strbuf only
once, save the prefix length and reset using strbuf_setlen() in every
loop iteration. Thanks!
