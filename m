Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A351EC433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 13:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A7A206A5
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 13:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbgFWNVM convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 23 Jun 2020 09:21:12 -0400
Received: from elephants.elehost.com ([216.66.27.132]:26230 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgFWNVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 09:21:11 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 05NDL8cP072376
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 Jun 2020 09:21:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Pratyush Yadav'" <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
References: <00dd01d63d9d$65f5dda0$31e198e0$@nexbridge.com> <20200623124726.3f3g7gmm7zfwxvhu@yadavpratyush.com>
In-Reply-To: <20200623124726.3f3g7gmm7zfwxvhu@yadavpratyush.com>
Subject: RE: [BUG] Installing git-gui (2.27.0)
Date:   Tue, 23 Jun 2020 09:21:02 -0400
Message-ID: <009701d64961$27667610$76336230$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG4wJwmPlEPIJFEg1dkHNhCXt8/tAN8P8I6qQVdxXA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On, June 23, 2020 8:47 AM, Pratyush Yadav:
> On 08/06/20 10:02AM, Randall S. Becker wrote:
> > Hi,
> >
> > This is what I found when trying to install the whole git package on
> > the NonStop TNS/E platform:
> >
> >  DEST /usr/local/share/git-gui/lib
> >     INSTALL 644 tclIndex
> > install: cannot stat 'lib/tclIndex': No such file or directory
> > Makefile:293: recipe for target 'install' failed
> >
> > I’m not sure why we are only hitting this now at 2.27.0. We don’t use
> > git-gui anyway on this platform as it has no GUI interface. It looks
> > like the install script runs auto_mkindex that actually does nothing
> > in our case, so lib/tclIndex is not built.
> >
> > This does block the install from completing successfully. To bypass, I
> > added the following:
> >
> > index f10caedaa7..943febaf75 100644
> > --- a/git-gui/Makefile
> > +++ b/git-gui/Makefile
> > @@ -256,6 +256,7 @@ lib/tclIndex: $(ALL_LIBFILES) GIT-GUI-VARS
> >           $(foreach p,$(PRELOAD_FILES),source $p\;) \
> >           auto_mkindex lib $(patsubst lib/%,%,$(sort $(ALL_LIBFILES))) \
> >         | $(TCL_PATH) $(QUIET_2DEVNULL); then : ok; \
> > +        echo >>$@ ; \
> >         else \
> >          echo >&2 "    * $(TCL_PATH) failed; using unoptimized loading";
\
> >          rm -f $@ ; \
> >
> 
> IIUC, this is a NonStop-specific problem. This fix shouldn't go in the
git-gui
> 'master', right?

The component is still part of the git build, so unless it can be severed by
configuration, it should go into 'master'. The Makefile should still
generate a tclIndex, which the foreach is not guaranteed to do, apparently.

Randall


