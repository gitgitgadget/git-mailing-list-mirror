From: Olaf Hering <olaf@aepfle.de>
Subject: Re: implement a stable 'Last updated' in Documentation
Date: Wed, 28 Jan 2015 09:02:14 +0100
Message-ID: <20150128080214.GA18851@aepfle.de>
References: <20150126172409.GA15204@aepfle.de>
 <xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:02:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGeRH-0001Lz-JY
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 03:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbbA2CCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 21:02:31 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:19005 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbbA2CCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 21:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1422496948; l=2013;
	s=domk; d=aepfle.de;
	h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Subject:Cc:To:From:Date;
	bh=N5kDsIAMFMb1fHw92Tv8eDey3McYmzuHqKjaXZWoxC4=;
	b=oeuFZJw9TyMiJhE5H9xg3FCULFDggf0pz9QYO1ORPrmRJ+VDaYbjG66TmYGzpMoJB26
	ar/1l2Cox276KEw172uTakHWkQJN/2wIyQpKdS3FqL31r/lnkwOMQEFQEAE0vnDsEVLo7
	+QJTHwqBai6htL1zlq6xntWPOON27sB3mb0=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIlSQZelGPTkz+JJHiQM2XCL4FiyQ+n/+A0DGQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1087:7e01:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.1 AUTH)
	with ESMTPSA id a0516ar0S82E6dv
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Wed, 28 Jan 2015 09:02:14 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id 6113E5016F; Wed, 28 Jan 2015 09:02:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263132>

On Tue, Jan 27, Junio C Hamano wrote:

> Olaf Hering <olaf@aepfle.de> writes:
> 
> > Several files in Documentation have an unstable 'Last updated' timestamp. The
> > reason is that their mtime changes every time, which prevents reproducible
> > builds.
> >
> > 341 technical/api-index.txt: technical/api-index-skel.txt \
> > 342         technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
> > 343         $(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
> >
> > 388 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
> > 389         $(QUIET_GEN)$(RM) $@+ $@ && \
> > 390         '$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
> > 391         mv $@+ $@
> >
> > 399 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
> > 400         $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> > 401         sed -e '1,/^$$/d' $< | \
> > 402         $(TXT_TO_HTML) - >$@+ && \
> > 403         mv $@+ $@
> 
> All of them seem to have dependencies so it seems to me that two
> builds back to back without actually changing their input would not
> re-build anything.  What am I missing???

Per default the files referenced do not exist, so a build from releases
will generate the files. But I agree, perhaps there should be some
refactoring to handle dependencies properly.
In any case, if the 'Last updated' is unavoidable some reference is
required, see my patch in the other mail.

> > What file timestamp should be used for them? Likely "../version"?
> 
> I tend to think the "Last updated" timestamp taken from the
> filesystem timestamp is a bad practice inherited by these tools from
> the days back when nobody used any revision control systems.

I'm not sure. The bug is that such 'Last updated' line exists at all in
the default output. Noone asked for it, noone really needs it. And it
makes it impossible to get reproducible builds.
But so far I found no way to avoid the 'Last updated' output. The docs
and google suggest something like :last-updated-time!:, which did not
work for me.

Olaf
