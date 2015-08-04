From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Tue, 04 Aug 2015 06:34:01 +0200
Message-ID: <20150804043401.4494.43725@typhoon>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
To: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 06:41:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMU2B-0000LQ-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 06:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbbHDEkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 00:40:51 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:46988 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbHDEku convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 00:40:50 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Aug 2015 00:40:50 EDT
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 672caf47;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 4 Aug 2015 06:34:09 +0200 (CEST)
User-Agent: alot/0.3.6
In-Reply-To: <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275237>

On Thu, 09 Jul 2015 at 20:24:08, Sebastian Schuberth wrote:
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  builtin/clone.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 00535d0..ebcb849 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -147,6 +147,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
>  static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>  {
>         const char *end = repo + strlen(repo), *start;
> +       size_t len;
>         char *dir;
>  
>         /*
> @@ -173,19 +174,11 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>         /*
>          * Strip .{bundle,git}.
>          */
> -       if (is_bundle) {
> -               if (end - start > 7 && !strncmp(end - 7, ".bundle", 7))
> -                       end -= 7;
> -       } else {
> -               if (end - start > 4 && !strncmp(end - 4, ".git", 4))
> -                       end -= 4;
> -       }
> +       strip_suffix(start, is_bundle ? ".bundle" : ".git" , &len);
> [...]

I am currently on vacation and cannot bisect or debug this but I am
pretty confident that this patch changes the behaviour of directory name
guessing. With Git 2.4.6, cloning http://foo.bar/foo.git/ results in a
directory named foo and with Git 2.5.0, the resulting directory is
called foo.git.

Note how the end variable is decreased when the repository name ends
with a slash but that isn't taken into account when simply using
strip_suffix() later...

Is this intended?
