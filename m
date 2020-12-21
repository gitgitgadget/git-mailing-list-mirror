Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA153C433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FE522B3B
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLUTYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 14:24:31 -0500
Received: from elephants.elehost.com ([216.66.27.132]:31458 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLUTYa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 14:24:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BLJNjCa014059
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 21 Dec 2020 14:23:46 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <002001d6d7bd$d03d7e10$70b87a30$@nexbridge.com> <xmqqeejjm2ek.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeejjm2ek.fsf@gitster.c.googlers.com>
Subject: RE: [BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in libcurl
Date:   Mon, 21 Dec 2020 14:23:39 -0500
Message-ID: <003e01d6d7ce$ccc648f0$6652dad0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIwVeHqb+URxytNBq/tRiP96V2evAOu4pNCqTFyr2A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 21, 2020 1:37 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> 
> > The NonStop platform does not have an implementation of OpenLDAP, but
> > git is attempting to use it. We are getting unresolved references from
> > libcurl, which makes references to openldap regardless of whether it
> > exists. We do not expect git to use ldap_setup_connection, for
> > example. We need a way of disabling the use of this package. This
> > appears to be is a net new for issue for 2.23.0, which we just did not
get far
> enough on rc0 to encounter.
> 
> I assume "23" on the last line is typo for "30".

Yes, I goofed up here. 2.30.

> Between v2.29.0..v2.30.0-rc1, there is nothing other than 3b990aa6
> (push: parse and set flag for "--force-if-includes", 2020-10-03), which
seem
> to have nothing to do with auth, that touches http*.c or remote-curl.c
> 
> Is it possible that you updated your build procedure and/or options for
libcurl
> since last time you built a working Git successfully?

The only change on the system anywhere near the toolchain was removing
MKDIR_WO_TRAILING_SLASH and  NO_SETITIMER.

> If you build v2.29.0 with the same toolchain and library that failed with
-rc1,
> does the result work OK?
> 
> Does NonStop software collection have programs other than Git that links
> with libcurl, and if so do they work (in other words, is the latest source
of Git
> the only thing that suffers from this issue)?

git is the only product my group builds that uses libcurl. There is a less
functional
version of libcurl that comes with the operating system that we ignore. We
are not
linking with that version. The version of curl we have, we built but not
since 2.29.2.
So  I'm confused.

> 
> Sorry, I have *no* further suggestions even if you answered any of the
above
> questions to me, but I hope others (inclusing you and your
> folks) may have better insights after answering the above questions
> ;-)
> 
> > Need assistance to resolve this.
> >
> > Thanks,
> > Randall
> >
> > Sample (there are more) references:
> >
> > eld command line:
> >    /usr/bin/eld -o git-imap-send -set systype oss -set highpin on -set
> >    highrequestor on -set inspect on /usr/lib/ccplmain.o imap-send.o
http.o
> >    common-main.o -L/usr/local/lib -lcurl -lssl -lcrypto -lssl -lcrypto
-lz
> >    -lssl -lcrypto -lcrypto libgit.a xdiff/lib.a -lz -lintl -liconv
> >    -L/usr/local/lib -lfloss -lutil -lrld -L /G/system/sys04 -lcre -lcrtl
> >    -lossk -lossf -lsec -li18n -licnv -losse -linet -lossh -lossc
> >    -allow_duplicate_procs
> >
> > **** ERROR **** [1210]:
> >    /usr/local/lib/libcurl.a(libcurl_la-openldap.o): In function
> >    `ldap_setup_connection':
> >    libcurl_la-openldap.o(.text._153926392+0x72): unresolved reference to
> >    ldap_url_parse.
> >
> >
> > -- Brief whoami:
> >  NonStop developer since approximately 211288444200000000  UNIX
> > developer since approximately 421664400
> > -- In my real life, I talk too much.

