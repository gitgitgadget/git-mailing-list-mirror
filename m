From: Olaf Hering <olaf@aepfle.de>
Subject: implement a stable 'Last updated' in Documentation
Date: Mon, 26 Jan 2015 18:24:09 +0100
Message-ID: <20150126172409.GA15204@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 18:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFnOg-0000bv-1u
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 18:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbbAZRYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 12:24:13 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:25341 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbbAZRYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 12:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1422293050; l=935;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=Q7A3s5CdZhZydUjRfVQL0Yvi1Xx0u4WWaCWItOXo8ko=;
	b=xreeHBa03bc9AUrPLvRgkiJelUEke7Ng5bAMtsbDCbWfaexz24mRbACeperPKdFjCaR
	rk3C8tiHOG0mpnIr9yZvrl3ffwqHMQNnK+2Kj1d27Jx2YKQoro0sRfN4CKdkz4fTntJiF
	w/AlcgwI4F9xhlRlebB/uk7GeR4NGs3jg8c=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnBYfssDIlSQZelGPTkz+JJHiQM2XCL4FiyQ+n/+A0DGQ==
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a60:1087:7e01:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.1 AUTH)
	with ESMTPSA id c02a4fr0QHOA1ln
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Mon, 26 Jan 2015 18:24:10 +0100 (CET)
Received: by probook.fritz.box (Postfix, from userid 1000)
	id F2D825016F; Mon, 26 Jan 2015 18:24:09 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.22.rev6346 (2013-10-29)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263038>


Several files in Documentation have an unstable 'Last updated' timestamp. The
reason is that their mtime changes every time, which prevents reproducible
builds.

341 technical/api-index.txt: technical/api-index-skel.txt \
342         technical/api-index.sh $(patsubst %,%.txt,$(API_DOCS))
343         $(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh

388 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
389         $(QUIET_GEN)$(RM) $@+ $@ && \
390         '$(SHELL_PATH_SQ)' ./howto-index.sh $(sort $(wildcard howto/*.txt)) >$@+ && \
391         mv $@+ $@

399 $(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
400         $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
401         sed -e '1,/^$$/d' $< | \
402         $(TXT_TO_HTML) - >$@+ && \
403         mv $@+ $@

What file timestamp should be used for them? Likely "../version"?
The final file, before passing it to asciidoc, should get a fixed timestamp
with 'touch -r $reference_file $file'.

Olaf
