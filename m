From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v3 5/5] rm: delete .gitmodules entry of submodules
 removed from the work tree
Date: Tue, 30 Jul 2013 22:15:11 +0200
Message-ID: <20130730201511.GC19369@paksenarrion.iveqy.com>
References: <51F8187F.7040603@web.de>
 <51F81957.1000709@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 30 22:12:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4GHh-0002mR-Cm
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 22:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010Ab3G3UMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 16:12:37 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:42224 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852Ab3G3UMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 16:12:36 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so3753914lab.34
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 13:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1+qjfyxHpA6Wzf4kCQfBkvU0PEHERCt9WDJGjkisw2U=;
        b=uM2Yr4JuanV2Ue+uNdO69vnPi3GJBnGw2T1rZyocxdhQShNvLS9pxLp2T1POkoHQ3v
         gDkXkVW/Nl2sU3faTqdbWPtShY5INXECMAnAZqeIH1xNYYluFM9Y6twaVhCXTCymd9Mg
         VfbjD0xdaids3a2pCDYGg4cAsaoenY8kLrfOkg1VEpmeInIp9M/coXkmogIBmcNn2u6+
         LrYxX686zYEYe5jL3n5ej83ToIamlTnJSs0mIgiZXYcb1VEk5UnCgt5k5umQzu3MzRMq
         uaBZ9hk/ggiETrwl9ENK6aWWdA4aMYDv0fOhCO/058hohq2kOqu/tN0UWkj2S4josI9u
         y+iA==
X-Received: by 10.152.22.232 with SMTP id h8mr29363076laf.37.1375215155335;
        Tue, 30 Jul 2013 13:12:35 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id js17sm9092069lab.5.2013.07.30.13.12.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 13:12:34 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V4GK7-0003Pg-Nt; Tue, 30 Jul 2013 22:15:11 +0200
Content-Disposition: inline
In-Reply-To: <51F81957.1000709@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231389>

On Tue, Jul 30, 2013 at 09:51:51PM +0200, Jens Lehmann wrote:
> +/*
> + * Try to remove the "submodule.<name>" section from .gitmodules whe=
re the given
> + * path is configured. Return 0 only if a .gitmodules file was found=
, a section
> + * with the correct path=3D<path> setting was found and we could rem=
ove it.
> + */
> +int remove_path_from_gitmodules(const char *path)
> +{
> +	struct strbuf sect =3D STRBUF_INIT;
> +	struct string_list_item *path_option;
> +
> +	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules =
*/
> +		return -1;
> +
> +	if (gitmodules_is_unmerged)
> +		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts=
 first"));
> +
> +	path_option =3D unsorted_string_list_lookup(&config_name_for_path, =
path);
> +	if (!path_option) {
> +		warning(_("Could not find section in .gitmodules where path=3D%s")=
, path);
> +		return -1;
> +	}
> +	strbuf_addstr(&sect, "submodule.");
> +	strbuf_addstr(&sect, path_option->util);
> +	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL=
) < 0) {
> +		/* Maybe the user already did that, don't error out here */
> +		warning(_("Could not remove .gitmodules entry for %s"), path);
> +		return -1;
> +	}
> +	strbuf_release(&sect);
> +	return 0;
> +}

This question applies for this function and a few more functions in thi=
s
patch that has the same characteristics.

If we're in a state when we need to return non-zero, we don't do any
cleaning (that is strbuf_release()). Since this file is in the part
called libgit AFAIK, shouldn't we always clean after us?

Would it make sense to have different return values for different
errors?

I do like the comments above the function, more functions (at least
non-static ones) should follow this good style IMHO.
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
