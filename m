From: Andreas Ericsson <ae@op5.se>
Subject: Re: git describe bug?
Date: Tue, 06 Apr 2010 11:48:39 +0200
Message-ID: <4BBB0377.8080007@op5.se>
References: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net> <20100402183147.GA20007@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Dustin Sallings <dustin@spy.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 11:54:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz5UG-0002GG-TA
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 11:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0DFJyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 05:54:20 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43598 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751617Ab0DFJyS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 05:54:18 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2010 05:54:18 EDT
Received: from source ([72.14.220.155]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS7sEyY/URF4i+xMUv8xsF/qBkrjfqRzx@postini.com; Tue, 06 Apr 2010 02:54:18 PDT
Received: by fg-out-1718.google.com with SMTP id l26so818233fgb.15
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 02:54:17 -0700 (PDT)
Received: by 10.87.29.33 with SMTP id g33mr10494417fgj.27.1270547323521;
        Tue, 06 Apr 2010 02:48:43 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id d8sm11962113fga.26.2010.04.06.02.48.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 02:48:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <20100402183147.GA20007@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144124>

On 04/02/2010 08:31 PM, Shawn O. Pearce wrote:
> Dustin Sallings<dustin@spy.net>  wrote:
>>
>> 	describe does not choose the most recent tag when multiple tags point to a single commit (for example, when an RC release becomes a proper release).
>>
>> 	There's a bit of conflict in the documentation between the following:
>>
>> 		``tags with newer dates will always be preferred over tags with older dates''
>>
>> 	and the next sentence:
>>
>> 		``If an exact match is found, its name will be output and searching will stop.''
>>
>> 	The code does not allow for multiple exact matches, leading to what I would consider incorrect behavior as shown below:
> 
> Yes, I've seen this too.  IIRC we've actually discussed this in
> the past.  I can't find the thread (my search skills are sub-par
> despite who I work for...).  But the general idea if I remember
> it right was we wanted to use the older tag, because that tag
> came first.
> 

Right now the behaviour is inconsistent. In the latest git repo
I tried the following:
  $ git tag -a v99 -msdf
  $ git tag -a v100 -m100
  $ git describe
v100
  $ git describe v99
v100
  $ git describe v100
v100
  $ git show v99
tag v99
Tagger: Andreas Ericsson <ae@op5.se>
Date:   Tue Apr 6 11:27:28 2010 +0200

sdf

commit 8b5fe8c9ec3f961ec9b09844eca6225f06af5b0b
...
  $ git show v100
tag v100
Tagger: Andreas Ericsson <ae@op5.se>
Date:   Tue Apr 6 11:27:37 2010 +0200

100

commit 8b5fe8c9ec3f961ec9b09844eca6225f06af5b0b
...

  $ ls .git/refs/tags/v{100,99}
.git/refs/tags/v100  .git/refs/tags/v99

So as you can see, something else is going on. Both tags here are
stashed as loose objects and both refs are unpacked.

Using either strverscmp(3) or allowing one to sort by tagging date
with the option to use first or latest would be preferrable. I'll
see what I can cook up during my lunch-break.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
