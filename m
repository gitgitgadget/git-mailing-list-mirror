From: =?UTF-8?B?TmFneSBCYWzDoXpz?= <js@iksz.hu>
Subject: Re: [PATCH] Added sub get_owner_file which checks if there's a file
 with project owner name
Date: Wed, 30 Jan 2008 16:59:14 +0100
Message-ID: <47A09ED2.6070407@iksz.hu>
References: <1201577766-11601-1-git-send-email-ribas@c3sl.ufpr.br> <200801291628.21026.jnareb@gmail.com> <479F925A.5020401@iksz.hu> <200801292236.19630.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 17:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKFLy-0002ZM-MX
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 16:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYA3P71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jan 2008 10:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbYA3P70
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 10:59:26 -0500
Received: from smtp.aranyoroszlan.hu ([195.56.77.57]:52616 "EHLO
	smtp.aranyoroszlan.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbYA3P7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 10:59:25 -0500
Received: (qmail 86720 invoked by uid 263); 30 Jan 2008 16:09:00 -0000
Received: from 217.20.140.62 (js@iksz.hu@217.20.140.62) by tcb.aranyoroszlan.hu (envelope-from <js@iksz.hu>, uid 256) with qmail-scanner-2.01st 
 (clamdscan: 0.88/1510. spamassassin: 3.1.0. perlscan: 2.01st.  
 Clear:RC:0(217.20.140.62):SA:0(0.9/5.0):. 
 Processed in 2.544486 secs); 30 Jan 2008 16:09:00 -0000
X-Spam-Status: No, hits=0.9 required=5.0
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on tcb.aranyoroszlan.hu
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=5.0 tests=AWL,BAYES_00,RDNS_NONE
	autolearn=no version=3.2.4
X-Envelope-From: js@iksz.hu
Received: from unknown (HELO ?192.168.1.100?) (js@iksz.hu@217.20.140.62)
  by tcb.aranyoroszlan.hu with SMTP; 30 Jan 2008 16:08:57 -0000
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200801292236.19630.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72058>

Jakub Narebski wrote:
> Nagy Bal=C3=A1zs wrote:
>  =20
>> Are you talking about I/O of an all-in CGI script? =20
>>    =20
>
> I am talking there between I/O difference between situation
> (configuration) when $projects_list is a directory (default),
> or is a file. If $projects_list is a directory, gitweb scans
> directory structure to find git repositories, which for large
> number of repositories might take time, even with filesystem
> cache, and with depth of searching bound by $project_maxdepth.
> Add to that finding symbolic name of the owner of repository
> directory, or (with the patch) reading a file per repo with repo
> owner.
>  =20
We have two configurable options here: $projectroot and $projects_list.=
 =20
If $projects_list is a directory, we'll end up using a directory to get=
=20
project list info, and using another one to actually handle the=20
projects.  In small repo area it's safe to have $projects_list empty. =20
This is why I reference $projects_list as a file.

If $projects_list is a file, we'll rely on a file which was generated=20
some time ago and can't reflect the latest changes of $projectroot (but=
=20
see below).
>> We can tune the =20
>> performance of this script, but changing the GIT_DIR structure just=20
>> because of a simple script is a bit overkill to me.
>>
>> What if this script creates the $projects_list file, for example whe=
n=20
>> the $projectroot's mtime changes?  We can even hold mtime info for e=
very=20
>> project's config file.
>>    =20
>
> I don't understand what you wanted to say here. $projects_list file
> lists only project path (project name) and project owner.
>  =20
I mean it would be better to add this kind of metadata like description=
=20
and owner's shoesize to config instead of a raw file.  I understand row=
=20
files are easier to read but reading a single cache file adn doing some=
=20
stat()s are much easier.  I can think of $project_lists as a cache file=
=20
name, which can be maintained by gitweb.cgi, and these mtime values=20
could be saved to $project_list to verify entries' validity.

All we have to do is to maintain $project_list to be up to date.  The=20
best would be to have a separate projectlist maintainer script which=20
handles two scenarios:

1| repo addition/deletion
2| repo config changes

I don't have solution for the first scenario which would be a speed=20
improvement in gitweb.cgi, this is why I suggest to put $project_list=20
updater to a separate script.  The second scenario could be handled by=20
gitweb.cgi though, but it would be mere code duplication.

Regards:
--=20
Balazs Nagy
