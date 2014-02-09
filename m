From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: gitweb.cgi bug
Date: Sun, 9 Feb 2014 11:06:05 -0500
Message-ID: <F6951DEA-C9E6-4936-BC36-E5ADA7CE467E@kellerfarm.com>
References: <CAE8XmWqH__rx+OvO-xOejWz_TrQitJ2rHJgp1gxOzNVNmrkJmQ@mail.gmail.com> <0FE68796-BA98-4DF7-AD30-C42D78A87DCE@kellerfarm.com> <CAE8XmWo-SiRTZjUt9Z2UZeJW21NuKEgf1J43QS4HECPBA4ceWA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 09 17:06:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCWtq-0000Hz-0g
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 17:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbaBIQGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 11:06:10 -0500
Received: from atl4mhob13.myregisteredsite.com ([209.17.115.51]:51663 "EHLO
	atl4mhob13.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612AbaBIQGJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Feb 2014 11:06:09 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.205])
	by atl4mhob13.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s19G66dx017596
	for <git@vger.kernel.org>; Sun, 9 Feb 2014 11:06:06 -0500
Received: (qmail 30054 invoked by uid 0); 9 Feb 2014 16:06:06 -0000
X-TCPREMOTEIP: 23.28.12.255
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.103?) (andrew@kellerfarm.com@23.28.12.255)
  by 0 with ESMTPA; 9 Feb 2014 16:06:06 -0000
In-Reply-To: <CAE8XmWo-SiRTZjUt9Z2UZeJW21NuKEgf1J43QS4HECPBA4ceWA@mail.gmail.com>
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241880>

On Feb 8, 2014, at 10:19 PM, Dongsheng Song wrote:
> On Sun, Feb 9, 2014 at 12:29 AM, Andrew Keller <andrew@kellerfarm.com> wrote:
>> On Feb 8, 2014, at 8:37 AM, Dongsheng Song wrote:
>> 
>>> I have an git repo PROJECT.git, the full path is /srv/repo/git/PROJECT.git,
>>> when I set git_base_url_list in gitweb.conf:
>>> 
>>> @git_base_url_list = qw(https://192.168.30.239/repo/git
>>>                           git@192.168.30.239:repo/git);
>>> 
>>> I got the result:
>>> 
>>> https://192.168.30.239/repo/git/PROJECT.git
>>> git@192.168.30.239:/PROJECT.git
>>> 
>>> This is wrong, it should be (without the leading '/')
>>> git@192.168.30.239:PROJECT.git
>> 
>> There is no way to generate a fetch url of 'git@192.168.30.239:PROJECT.git' in gitweb.
>> 
>> If one of the base urls was 'git@192.168.30.239:.', then you could get a fetch URL of 'git@192.168.30.239:./PROJECT.git'
>> 
>> In general, though, I like to stay away from relative paths.  Weird things can happen, like HTTP works but SSH doesn't, because the home directory for SSH changed because you used a different user.
> 
> What's about the following translate rules ?
> 
> git@192.168.30.239:  -> git@192.168.30.239:PROJECT.git
> git@192.168.30.239:/ -> git@192.168.30.239:/PROJECT.git
> git@192.168.30.239:/repo  -> git@192.168.30.239:/repo/PROJECT.git
> git@192.168.30.239:/repo/ -> git@192.168.30.239:/repo/PROJECT.git

I think that those translation rules are completely reasonable.

However, that's not what gitweb was originally designed to do.  What you're describing is a desire for a new feature, not the existence of a bug.  Basically, gitweb does not support relative paths when the base url does not contain part of the path already.

> I don't know Perl, but I think change the following translate code is
> not a hard work:
> 
>        # use per project git URL list in $projectroot/$project/cloneurl
>        # or make project git URL from git base URL and project name
>        my $url_tag = "URL";
>        my @url_list = git_get_project_url_list($project);
>        @url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
>        foreach my $git_url (@url_list) {
>                next unless $git_url;
>                print format_repo_url($url_tag, $git_url);
>                $url_tag = "";
>        }

You're right - that is where the change should be applied, and the change you suggest is pretty simple.

However, I'm not confident that the syntax for a relative path is the same for all schemes.  (Others on the list, feel free to object.)  Since gitweb blindly concatenates the base URL and the relative project path, I'm worried that adding the proper functionality for one scheme will yield incorrect behavior for another scheme.

Can you move your repository to a subfolder?  Can use use absolute paths instead of relative paths?  Either of those approaches work around this issue.  I don't mean to coldly tell you that the solution is "don't do that", but on the surface, this seems like a nasty problem.

 - Andrew
