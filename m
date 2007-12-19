From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 12:43:12 +0100
Message-ID: <CA30F61D-4AE1-4100-A632-20B5587EB4D0@wincent.com>
References: <20071219105752.GA23932@hashpling.org> <23306E3C-24F1-4626-A956-02531644B786@wincent.com> <20071219113617.GA26520@hashpling.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:43:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xKu-0003Ho-6i
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbXLSLnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbXLSLnR
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:43:17 -0500
Received: from wincent.com ([72.3.236.74]:35525 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbXLSLnQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 06:43:16 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBJBhDrq018892;
	Wed, 19 Dec 2007 05:43:14 -0600
In-Reply-To: <20071219113617.GA26520@hashpling.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68892>

El 19/12/2007, a las 12:36, Charles Bailey escribi=F3:

> On Wed, Dec 19, 2007 at 12:28:04PM +0100, Wincent Colaiuta wrote:
>>
>> I think it's a bad idea to hard-code the perl path there; the
>> generated scripts only assume /usr/bin/perl if the user hasn't
>> overridden it at build time:
>>
>> 	PERL_PATH=3D/foo/perl make ...
>>
>> Using just this should work fine anyway:
>>
>> 	perl -p -e ...
>>
>
> I agree completely, but all the generated scripts output hard coded
> paths so it would seem inconsistent not to qualify the path in this
> case too.

It's not hard-coded, it's dynamic. Witness:

$ make PERL_PATH=3D/Volumes/Clon/usr/bin/perl
$ head -1 git-add--interactive
#!/Volumes/Clon/usr/bin/perl -w

>  Would  @@PERL_PATH@@perl -p -e work, do you know?

I don't think so, but judging from the following section of the =20
Makefile, I think @@PERL@@ would. Why don't you give it a try?

$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
         $(QUIET_GEN)$(RM) $@ $@+ && \
         sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
             -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
             -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
             -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
             -e 's|@@HTMLDIR@@|$(htmldir_SQ)|g' \
             $@.sh >$@+ && \
         chmod +x $@+ && \
         mv $@+ $@

Cheers,
Wincent
