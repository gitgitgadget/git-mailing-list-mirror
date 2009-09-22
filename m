From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Tue, 22 Sep 2009 09:52:31 -0500
Message-ID: <Hfm4AdtlXpMutgmdj0vm7yb0ucfu_cijUloasBDWh6NfRCwLhP4OCA@cipher.nrlssc.navy.mil>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com> <7vocp4ulq2.fsf@alter.siamese.dyndns.org> <20090922113151.GO8173@gryning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: c@gryning.com
X-From: git-owner@vger.kernel.org Tue Sep 22 16:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq6jd-0004vI-Iu
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 16:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805AbZIVOwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756803AbZIVOwp
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 10:52:45 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48505 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbZIVOwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 10:52:43 -0400
Received: by mail.nrlssc.navy.mil id n8MEqVbN021216; Tue, 22 Sep 2009 09:52:40 -0500
In-Reply-To: <20090922113151.GO8173@gryning.com>
X-OriginalArrivalTime: 22 Sep 2009 14:52:31.0936 (UTC) FILETIME=[50263400:01CA3B94]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128936>

Craig Taylor wrote:
> On Mon, Sep 21, 2009 at 12:44:05PM -0700, Junio C Hamano wrote:
>> Craig Taylor <c@gryning.com> writes:
>>
>>> Exactly as you describe here, different paths but same goal.
>>> All binaries follow the DESTDIR path except the perl modules.
>>>
>>> To register this as a bug do I need to do more than send this email?
>> Do you use NO_PERL_MAKEMAKER in your build?
>>
>> If not, we need to summon an expert on ExtUtils::MakeMaker to look into
>> this issue, but if you do, perhaps you can try this patch and report how
>> well it works for you.
>>
>> ---
>>  perl/Makefile |    8 ++++----
>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/perl/Makefile b/perl/Makefile
>> index e3dd1a5..4ab21d6 100644
>> --- a/perl/Makefile
>> +++ b/perl/Makefile
>> @@ -29,11 +29,11 @@ $(makfile): ../GIT-CFLAGS Makefile
>>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>>  	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
>>  	echo install: >> $@
>> -	echo '	mkdir -p "$(instdir_SQ)"' >> $@
>> -	echo '	$(RM) "$(instdir_SQ)/Git.pm"; cp Git.pm "$(instdir_SQ)"' >> $@
>> -	echo '	$(RM) "$(instdir_SQ)/Error.pm"' >> $@
>> +	echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)"' >> $@
>> +	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Git.pm"; cp Git.pm "$$(DESTDIR)$(instdir_SQ)"' >> $@
>> +	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>>  	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
>> -	echo '	cp private-Error.pm "$(instdir_SQ)/Error.pm"' >> $@
>> +	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
>>  	echo instlibdir: >> $@
>>  	echo '	echo $(instdir_SQ)' >> $@
>>  else
> 
> 
> Further to my last email, modifying the perl.mak file as below resolves
> the problem for me to a satisfactory level.
> I will have to leave a more permanent solution to someone more familar with
> make/makemaker.
> 
> --- git-1.6.4.4/perl/perl.mak_to20090922        2009-09-22 12:07:18.000000000 +0100
> +++ git-1.6.4.4/perl/perl.mak   2009-09-22 12:21:17.791887000 +0100
> @@ -57,7 +57,7 @@
>  INST_LIB = blib/lib
>  INST_ARCHLIB = blib/arch
>  INST_SCRIPT = blib/script
> -PREFIX = /usr/local/git-1.6.4.4
> +PREFIX = $(DESTDIR)/usr/local/git-1.6.4.4
>  INSTALLDIRS = site
>  INSTALLPRIVLIB = $(PREFIX)/lib/5.6.1
>  INSTALLARCHLIB = $(PREFIX)/lib/5.6.1/sun4-solaris

I have not been able to reproduce your problem on Solaris.  The DESTDIR
feature is working for me.

Possibly it is related to the version of MakeMaker?  I am using version
6.17 (Revision: 1.133) along with Perl 5.8.4 on Solaris 10 x86.  The
MakeMaker version should be in the header at the top of the perl.mak
file.

The perl.mak snippet that you provided above looks different than mine.
In mine, in the vicinity of the 'PREFIX = ' line I also have a
'DESTDIR = ' line.  The right hand side of 'DESTDIR = ' is empty even
when I specify a DESTDIR on the make command line.

Here's a snippet from my perl.mak file:

   DESTDIR =
   PREFIX = /usr/local/git-1.6.4.4
   PERLPREFIX = $(PREFIX)
   SITEPREFIX = $(PREFIX)
   VENDORPREFIX = $(PREFIX)
   INSTALLPRIVLIB = $(PERLPREFIX)/lib
   DESTINSTALLPRIVLIB = $(DESTDIR)$(INSTALLPRIVLIB)
   INSTALLSITELIB = $(SITEPREFIX)/lib/site_perl
   DESTINSTALLSITELIB = $(DESTDIR)$(INSTALLSITELIB)
   INSTALLVENDORLIB = $(VENDORPREFIX)/lib
   DESTINSTALLVENDORLIB = $(DESTDIR)$(INSTALLVENDORLIB)
   INSTALLARCHLIB = $(PERLPREFIX)/lib/i86pc-solaris-64int
   DESTINSTALLARCHLIB = $(DESTDIR)$(INSTALLARCHLIB)

Notice the variable assignments that begin with 'DEST'.  Does your
perl.mak file have those?  If not, then it seems MakeMaker is not
producing them for some reason.

Did you try Junio's patch?  If the version of MakeMaker is the problem,
then perhaps setting NO_PERL_MAKER=1 on the make command line along
with Junio's patch is the best way forward for you.

-brandon
