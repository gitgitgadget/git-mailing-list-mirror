From: Dongsheng Song <dongsheng.song@gmail.com>
Subject: Re: gitweb.cgi bug
Date: Sun, 9 Feb 2014 11:19:45 +0800
Message-ID: <CAE8XmWo-SiRTZjUt9Z2UZeJW21NuKEgf1J43QS4HECPBA4ceWA@mail.gmail.com>
References: <CAE8XmWqH__rx+OvO-xOejWz_TrQitJ2rHJgp1gxOzNVNmrkJmQ@mail.gmail.com>
 <0FE68796-BA98-4DF7-AD30-C42D78A87DCE@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Sun Feb 09 04:20:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCKwn-00063Z-Bs
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 04:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaBIDUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 22:20:09 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33610 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbaBIDUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 22:20:08 -0500
Received: by mail-ob0-f178.google.com with SMTP id wn1so5800138obc.23
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 19:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9I5r1jeu18joKPLua5N/ZOzGG3qt8N1QsNygH1CPdoQ=;
        b=CyrFFmdaqRXpD72VFAnxc3/SMU31LXkcC+Kbqhku1Ou0b6TLLyrWm6ynOYYbbomBBV
         orDSzc38aphfluQjLBHRqG/fYrSk8/qCyjegiHro9DqkMkXJN6wekswYFnBqc6QmuUqv
         sHm4d1GiuunSzs/8qFMG5Sp2vVtltfFDCdYox2XMDk0urBYWuQYfkh9dlFPpS6VV49Hh
         rhCRJ9WHaPCWBmo8T0U5OSfyUPYBKhoql+w0Jhv4YmdAyAyyLBVC5SVs3KOIMpd/hLwT
         9RfdFzgeZicmEY6oyzQcMRLr3lNTG0jyG9NPCxdFfJyqkK8D+k6izHSQI/GKlBFbpiAd
         baBA==
X-Received: by 10.182.146.104 with SMTP id tb8mr164595obb.54.1391916005211;
 Sat, 08 Feb 2014 19:20:05 -0800 (PST)
Received: by 10.182.240.16 with HTTP; Sat, 8 Feb 2014 19:19:45 -0800 (PST)
In-Reply-To: <0FE68796-BA98-4DF7-AD30-C42D78A87DCE@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241870>

On Sun, Feb 9, 2014 at 12:29 AM, Andrew Keller <andrew@kellerfarm.com> wrote:
> On Feb 8, 2014, at 8:37 AM, Dongsheng Song wrote:
>
>> I have an git repo PROJECT.git, the full path is /srv/repo/git/PROJECT.git,
>> when I set git_base_url_list in gitweb.conf:
>>
>> @git_base_url_list = qw(https://192.168.30.239/repo/git
>>                            git@192.168.30.239:repo/git);
>>
>> I got the result:
>>
>> https://192.168.30.239/repo/git/PROJECT.git
>> git@192.168.30.239:/PROJECT.git
>>
>> This is wrong, it should be (without the leading '/')
>> git@192.168.30.239:PROJECT.git
>
> There is no way to generate a fetch url of 'git@192.168.30.239:PROJECT.git' in gitweb.
>
> If one of the base urls was 'git@192.168.30.239:.', then you could get a fetch URL of 'git@192.168.30.239:./PROJECT.git'
>
> In general, though, I like to stay away from relative paths.  Weird things can happen, like HTTP works but SSH doesn't, because the home directory for SSH changed because you used a different user.
>
>  - Andrew
>

What's about the following translate rules ?

git@192.168.30.239:  -> git@192.168.30.239:PROJECT.git
git@192.168.30.239:/ -> git@192.168.30.239:/PROJECT.git
git@192.168.30.239:/repo  -> git@192.168.30.239:/repo/PROJECT.git
git@192.168.30.239:/repo/ -> git@192.168.30.239:/repo/PROJECT.git

I don't know Perl, but I think change the following translate code is
not a hard work:

        # use per project git URL list in $projectroot/$project/cloneurl
        # or make project git URL from git base URL and project name
        my $url_tag = "URL";
        my @url_list = git_get_project_url_list($project);
        @url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
        foreach my $git_url (@url_list) {
                next unless $git_url;
                print format_repo_url($url_tag, $git_url);
                $url_tag = "";
        }

Regards,
Dongsheng
