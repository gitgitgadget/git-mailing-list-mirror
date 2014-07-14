From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_file: do not add own object directory as alternate
Date: Mon, 14 Jul 2014 17:47:22 +0700
Message-ID: <CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com>
References: <53BFB055.206@gmail.com> <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com>
 <53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 12:48:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6dnb-0002Ms-Gp
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 12:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbaGNKr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 06:47:56 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:40541 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbaGNKry (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 06:47:54 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so3059701qaq.39
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 03:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UhvA1A1Ee0+v39ZQO7a5AokngbzUhGCDQbFcbEHUMXc=;
        b=jSYNUCH3M+lo1iFrYS//ekPzmRQ3JyP94ep0RIsarE5k1N7SuQetmThUpgIe5ixU5D
         rnM60oIMKCPDNEgzSls3w7/iNgO+Q5VbD6CrwAyjPHzhym7JKHhnkR+dh44bfVQd1s9i
         hBq4ff8mc701pfJfBZrap2p84dHeSbchL11a3mA6CEJiUPjHc+m7C5zPg5NAwUZqLCu/
         ZhYuCzn6seHEYgyu7z4itNDKXgO8iz97M3QfpWIAqjPwpXCFM13Sejo0J8uW4s2bRm1g
         DEXqsW8H/ZknwmrNFck7hYiHujXBtbfB9gjgo0iZB0PiWH+NCABzHzxRQktC2Coug0gG
         ZTjw==
X-Received: by 10.140.87.100 with SMTP id q91mr10111225qgd.21.1405334873828;
 Mon, 14 Jul 2014 03:47:53 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 14 Jul 2014 03:47:22 -0700 (PDT)
In-Reply-To: <53C39CB0.6040909@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253485>

On Mon, Jul 14, 2014 at 4:02 PM, Ephrim Khong <dr.khong@gmail.com> wrote:
> When adding alternate object directories, we try not to add the
> directory of the current repository to avoid cycles.  Unfortunately,
> that test was broken, since it compared an absolute with a relative
> path.

Not blaming anyone. I'm simply interested in code archeology. The
first introduction of this strcmp is from 1494e03 (sha1_file.c: make
sure packs in an alternate odb is named properly. - 2005-12-04). The
intention is good as described in the commit message. But I think it's
broken even back then because "objdir" (or get_object_directory())
will always be relative (unless someone sets it explicitly) and
ent->base back then is already absolute (but not normalized).

>
> Signed-off-by: Ephrim Khong <dr.khong@gmail.com>
> ---
> My first patch, so be harsh.  I'm not sure about the filename of the test,
> the behavior is tested with repack, but it affects gc and others as well.
>
>  sha1_file.c                        |  2 +-
>  t/t7702-repack-cyclic-alternate.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>  create mode 100755 t/t7702-repack-cyclic-alternate.sh
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 34d527f..7e98e9e 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -320,7 +320,7 @@ static int link_alt_odb_entry(const char *entry, const
> char *relative_base, int
>                         return -1;
>                 }
>         }
> -       if (!strcmp(ent->base, objdir)) {
> +       if (!strcmp(ent->base, absolute_path(objdir))) {

I think you want to normalize objdir in addition to making it
absolute, in case someone sets GIT_OBJECT_DIR to foo///bar. ent->base
is normalized already. Oh and maybe use strcmp_icase to be nice on
case-insensitive filesystems..

Kinda nit picking, but perhaps this path
absolute-ization/normalization should be done by the caller
link_alt_odb_entries so you don't have to redo it for every entry in
alternates file. I know there's a loop of memcmp() right above this
that may be more expensive than this micro-optimization when we have
lots of alternate entries.
-- 
Duy
