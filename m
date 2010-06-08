From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 08 Jun 2010 23:33:53 +0200
Message-ID: <4C0EB741.9020905@op5.se>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>	<20100608053507.GB15156@coredump.intra.peff.net>	<AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>	<4C0E5103.7030501@viscovery.net>	<AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com>	<4C0E6810.3070301@viscovery.net>	<AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com>	<4C0E932B.3010702@viscovery.net> <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:34:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM6R5-0002s1-Sz
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab0FHVeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 17:34:10 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:32881 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751424Ab0FHVeJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 17:34:09 -0400
Received: from source ([209.85.219.228]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTA63TZJ+vbCWInl5bHQRhC6sP6Gm11jL@postini.com; Tue, 08 Jun 2010 14:34:09 PDT
Received: by ewy28 with SMTP id 28so1458685ewy.18
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 14:34:04 -0700 (PDT)
Received: by 10.213.34.205 with SMTP id m13mr5517071ebd.23.1276032843910;
        Tue, 08 Jun 2010 14:34:03 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id 13sm3616088ewy.9.2010.06.08.14.34.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 14:34:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148721>

On 06/08/2010 10:44 PM, Dario Rodriguez wrote:
> On Tue, Jun 8, 2010 at 3:59 PM, Johannes Sixt<j.sixt@viscovery.net>  =
wrote:
>> Your repository has only 2 commits and its git log output is less th=
an 1kB,
>> i.e., sufficiently small to fit in a pipe's buffer.
>>
>> git log calls start_command to fork() the pager. The OS's scheduler =
does not
>> run the newly forked process immediately; rather, git log goes on wi=
th its
>> own business, writing output to the pipe that connects to the pager.=
 Because
>> your repository is so small, git log never has to wait that the page=
r drains
>> the pipe. git log finally reaches exit(0). At this time, an atexit()=
 handler
>> (wait_for_pager()) finally calls finish_command() to wait for the pa=
ger.
>>
>> This is the first time that the forked child process can run. Only n=
ow it
>> turns out that the pager cannot be run. The child process closes the=
 pipe
>> and exits with an error, but it is too late: wait_for_pager() drops =
the
>> error return code of finish_command() to the floor. The parent proce=
ss (git
>> log) can complete with the exit code that it was given earlier, 0.
>>
>> Repeat your experiment with ./git log in git.git itself to see the
>> difference.
>>
>> -- Hannes
>>
>=20
> Capisco&  touch=E9, with much more than 1k of info, git show ends wit=
h a
> "Broken Pipe"... seems hard to detect for little, recently started
> projects since I added more than 60k of scripts and I need to do 'git
> show' to understand that the problem is a broken pipe.
>=20
> Now, let me think about it... do we need the pager_preexec function? =
I
> mean... it works fine without it, and the function is there because o=
f
> a faulty 'less'.
>=20
> My problem is obvioulsly solved by adding PAGER=3Dmore in my default
> environment, but I think this could be a litle bit embarrassing for a
> new user, mostly in environments such this AIX :P
>=20

Catering to AIX by default seems stupid beyond belief. AIX users today
are, without fail, accustomed to having to tweak more or less everythin=
g
to make the system run smoothly with modern applications (where "modern=
"
is a generous term, including everything that's been written in the las=
t
10 or so years).

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
