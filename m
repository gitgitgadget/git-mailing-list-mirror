From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
	right after init
Date: Wed, 25 Mar 2009 07:35:10 -0400
Message-ID: <20090325113510.GB4437@coredump.intra.peff.net>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 12:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRPl-0004OK-4l
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbZCYLfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 07:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbZCYLfX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:35:23 -0400
Received: from peff.net ([208.65.91.99]:42709 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944AbZCYLfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 07:35:22 -0400
Received: (qmail 6302 invoked by uid 107); 25 Mar 2009 11:35:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 07:35:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 07:35:10 -0400
Content-Disposition: inline
In-Reply-To: <1237978720-2500-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114589>

On Wed, Mar 25, 2009 at 09:58:40PM +1100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> -'git init' [-q | --quiet] [--bare] [--template=3D<template_directory=
>] [--shared[=3D<permissions>]]
> +'git init' [-q | --quiet] [--bare] [--template=3D<template_directory=
>]
> +           [--shared[=3D<permissions>]] [-m|--import [<message>]]

What happened to --import=3D? Whether or not "--import <arg>" works, th=
e
--long-opt=3D form should always work.

> +		else if (!strcmp(arg, "--import") || !strcmp(arg, "-m")) {
> +			if (i+1 >=3D argc)
> +				import_message =3D "Initial commit";
> +			else {
> +				import_message =3D argv[2];
> +				i++;
> +				argv++;
> +			}
> +		}

This is the wrong way to do optional arguments. It means that

  git init --template=3Dfoo --import

is different from

  git init --import --template=3Dfoo

I think what you want is:

  else if (!strcmp(arg, "-m")) {
    if (i+1 >=3D argc)
      die("-m requires an import message");
    import_message =3D argv[2];
    i++;
    argv++;
  }
  else if (!strcmp(arg, "--import"))
    import_message =3D "Initial commit";
  else if (!prefixcmp(arg, "--import=3D"))
      import_message =3D arg+9;

That is, --import has a message or not depending on the '=3D', and "-m"
always has a message. If you want "-m" to optionally have a message the=
n
it must be used as

  git init -mfoo

-Peff
