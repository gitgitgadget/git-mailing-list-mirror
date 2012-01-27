From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH 0/4] config include directives
Date: Fri, 27 Jan 2012 10:51:34 +0100
Message-ID: <CACBZZX59sur4_61LkN_sMOvXQ4Jdnt1P8O-UOgm0SooBQpjFdQ@mail.gmail.com>
References: <20120126073547.GA28689@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 10:52:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqiTo-00089z-Oy
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 10:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab2A0Jv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 04:51:57 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39619 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750924Ab2A0Jv4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 04:51:56 -0500
Received: by lagu2 with SMTP id u2so846473lag.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 01:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9d7AXU065Ih4J3qXmh7Ga/JnXhDF7UJN1IvE91C0888=;
        b=jlA/6grXP1YkDYzEajD3VKrdVEnTdIrIUNgJkAd49Z2KxwkiZxHo5D6uC96QZHrVwf
         BMmtEgEUNyvB8GBOFSFENp5OZ1wagU2aB84UAAvhuZf4yYfEjuwDkKAtmc1CX0o3i1FP
         OXfF3n9PMq893cmwhtpuExnEtAjwyx6RVqNkA=
Received: by 10.112.23.133 with SMTP id m5mr1586470lbf.10.1327657914974; Fri,
 27 Jan 2012 01:51:54 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Fri, 27 Jan 2012 01:51:34 -0800 (PST)
In-Reply-To: <20120126073547.GA28689@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189211>

On Thu, Jan 26, 2012 at 08:35, Jeff King <peff@peff.net> wrote:
> This series provides a way for config files to include other config
> files in two ways:
>
> =C2=A01. From other files in the filesystem. This is implemented by p=
atch 1
> =C2=A0 =C2=A0 below, and is hopefully straightforward and uncontrover=
sial. =C2=A0See
> =C2=A0 =C2=A0 that patch for more rationale.
>
> =C2=A02. From blobs in the repo. This is implemented by patch 4, with
> =C2=A0 =C2=A0 patches 2 and 3 providing the necessary refactoring. Th=
is
> =C2=A0 =C2=A0 is one way of implementing the often asked-for "respect=
 shared
> =C2=A0 =C2=A0 config inside the repo" feature, but attempts to mitiga=
te some of
> =C2=A0 =C2=A0 the security concerns. The interface for using it safel=
y is a bit
> =C2=A0 =C2=A0 raw, but I think it's a sane building block, and somebo=
dy could
> =C2=A0 =C2=A0 write a fancier shared-config updater on top of it if t=
hey wanted
> =C2=A0 =C2=A0 to.
>
> =C2=A0[1/4]: config: add include directive
> =C2=A0[2/4]: config: factor out config file stack management
> =C2=A0[3/4]: config: support parsing config data from buffers
> =C2=A0[4/4]: config: allow including config from repository blobs

I expect you've thought about this, but our current API is (from
add.c):

	git_config(add_config, NULL);

=46ollowed by:

    static int add_config(const char *var, const char *value, void *cb)
    {
    	if (!strcmp(var, "add.ignoreerrors") ||
    	    !strcmp(var, "add.ignore-errors")) {
    		ignore_add_errors =3D git_config_bool(var, value);
    		return 0;
    	}
    	return git_default_config(var, value, cb);
    }

I.e. that function gets called with one key at a time, and stashes it
to a local value.

If you write the function like that it means your patch series just
works since values encountered later will override earlier ones, but
have you checked git's code to make sure we don't have anything like:

    static int ignore_add_errors_is_set =3D 0;
    static int add_config(const char *var, const char *value, void *cb)
    {
    	if (!ignore_add_errors_is_set &&
            (!strcmp(var, "add.ignoreerrors") ||
    	     !strcmp(var, "add.ignore-errors"))) {
    		ignore_add_errors =3D git_config_bool(var, value);
            ignore_add_errors_is_set =3D 1;
    		return 0;
    	}
    	return git_default_config(var, value, cb);
    }

Which would mean that the include config support would be silently
ignored.
