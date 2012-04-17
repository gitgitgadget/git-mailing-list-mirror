From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Option to omit column with time of the last change
Date: Wed, 18 Apr 2012 01:36:08 +0200
Message-ID: <201204180136.08570.jnareb@gmail.com>
References: <20120403132735.GA12389@camk.edu.pl> <201204162206.50631.jnareb@gmail.com> <20120416213938.GB22574@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 01:35:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKHvl-0002zG-KL
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 01:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab2DQXfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 19:35:25 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33174 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab2DQXfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 19:35:24 -0400
Received: by wibhj6 with SMTP id hj6so83045wib.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=b8KPHCjQUuS56QX8u86E3RK5ewnJPP80xzN6O+3krnw=;
        b=1KaUcsURgMsaBpBn901BjXmulCp/mx81wlWyPPFmJAFw8UoVuu69iq/PV3BPlmlFHd
         IrzNJVVxnQjXnGHPkoV5pQHAA2ZMOdj3YTXvbXdybeVjDdSgkypr3NulImlUuj9yYKb5
         TKdj+Sqvh70xB1ONPea2hzSNRoSAaV3AEH6NVZPfI0ooealVfeRFPWvDzrHb+b8YfbWp
         KfoYUFeTpgY7ZN80GnLNgnfxbst6MKwBgTshcw1+uQYn2Ns5Otq/Pa3J0VRyaz0Lwflb
         YcxW+SkXTXK/hk1Rd+vhs8l8boCJU6nrbUd6naSoJ3ZuEM1hEx14DGfWaNOs9UeNBsIn
         KRSg==
Received: by 10.180.24.35 with SMTP id r3mr11425574wif.7.1334705722199;
        Tue, 17 Apr 2012 16:35:22 -0700 (PDT)
Received: from [192.168.1.13] (epk75.neoplus.adsl.tpnet.pl. [83.20.52.75])
        by mx.google.com with ESMTPS id n8sm48565281wix.10.2012.04.17.16.35.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 16:35:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120416213938.GB22574@camk.edu.pl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195826>

On Mon, 16 Apr 2012, Kacper Kornet wrote:
> On Mon, Apr 16, 2012 at 10:06:49PM +0200, Jakub Narebski wrote:
>> On Mon, 16 Apr 2012, Kacper Kornet wrote:
>>> On Sat, Apr 14, 2012 at 03:16:01PM +0200, Jakub Narebski wrote:

>>>>   That saves I/O, but not fork.
>> 
>> Actually if you look at the footer of projects list page with 'timed'
>> feature enable you see that for N projects on list, gitweb uses 2*N+1
>> git commands.  The "+1" part is from "git version", the "2*N" are from
>> git-for-each-ref to get last activity (and verify repository as a
>> side-effect)...
> 
> It is how I started to think about the problem. With my additional patch
> to remove the owner I am able to reduce the number of git invocations to
> 1.

That is a very good thing.

Especially that adding caching to gitweb is long in coming (to core 
gitweb at least), and that not always one is able to turn on caching.

[...]
>>> My tests show that forks are also a bottleneck in my setup.
>> 
>> What do you mean by "my tests" here?  Is it benchmark (perhaps just using
>> 'timed' feature) with and without custom change removing fork(s)?  Or did
>> you used profiler (e.g. wondefull Devel::NYTProf) for that?
> 
> Nothing fancy. I look at the footnote produced by "timed" feature. And
> I see a difference between version with the following patch:
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 18cdf96..4a13807 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3156,6 +3156,18 @@ sub git_get_project_owner {
>  	return $owner;
>  }
>  
> +sub git_repo_exist {

Perhaps a better name would be validate_headref() or check_head(),
called from subroutine named either is_git_directory() as in setup.c,
or verify_repo()...

> +	my ($path) = @_;

BTW this could be written as

  +	my $path = shift;

though it is largely a matter of taste.

> +       my $fd;
> +
> +       $git_dir = "$projectroot/$path";
> +       open($fd, "<", "$git_dir/HEAD") or return;

It can be written as

  +	open my $fd, "<", "$projectroot/$path/HEAD"
  +		or return;

> +       my $line = <$fd>;
> +       close $fd or return;

Shouldn't we chomp($line)?

> +       return 1 if (defined $fd && substr($line, 0, 10) eq 'ref:refs/' 
> +           || $line=~m/^[0-9a-z]{40}$/);
> +       return 0;

I don't think we need to check that $fd is defined; if it isn't, we would
return earlier I think.

There can be space between "ref:" and fully qualified branch name, and in
fact git puts such space:

  $ cat .git/HEAD 
  ref: refs/heads/gitweb/web

Also, you can return boolean value.

So the above would reduce to:

  +	return ($line =~ m!^ref:\s*refs/! ||
  +	        $line =~ m!^[0-9a-z]{40}$!);

> +}
> +
>  sub git_get_last_activity {
>  	my ($path) = @_;
>  	my $fd;
> @@ -5330,6 +5342,7 @@ sub fill_project_list_info {
>  	my $show_ctags = gitweb_check_feature('ctags');
>   PROJECT:
>  	foreach my $pr (@$projlist) {
> +             next PROJECT unless git_repo_exist($pr->{'path'});

I understand that it is proof of concept patch, but I think that
in real patch iy would be better to update check_export_ok() instead
of this addition.

>  		if (project_info_needs_filling($pr, $filter_set->('age', 'age_string'))) {
>  			my (@activity) = git_get_last_activity($pr->{'path'});
>  			unless (@activity) {
> 
> 
> and the one in which  git_repo_exist() uses invocation to /bin/true:
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 18cdf96..4bcc66f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3156,6 +3156,13 @@ sub git_get_project_owner {
>  	return $owner;
>  }
>  
> +sub git_repo_exist {
> +	my ($path) = @_;
> +
> +        $git_dir = "$projectroot/$path";
> +        return not system('/bin/true');
> +}
> +

What were the differences in timing?

>>>                                                             On the other 
>>> hand I think that I can trust that my projects.list contains only valid
>>> repositories. So I would prefer to have a don't verify option. Or there
>>> is a possibility to write perl function with the same functionality as
>>> is_git_directory() from setup.c and use it to verify if the directory is a
>>> valid git repo.
>> 
>> Well, we can add those checks to check_export_ok()... well to function
>> it would call.
>> 
>> is_git_repository from setup.c checks that "/objects" and "/refs"
>> have executable permissions, and that "/HEAD" is valid via validate_headref
>> which does slightly more than (now slightly misnamed) check_head_link()
>> from gitweb...
>> 
>> ...or that DB_ENVIRONMENT i.e. GIT_OBJECT_DIRECTORY environment variable
>> is set, and path that it points to has executable permissions.  I don't
>> think we have to worry about this for gitweb.
> 
>> I'll try to come up with a patch to gitweb that improves repository
>> verification, and perhaps a patch that uses the fact that "git config"
>> succeeded to verify repository.
> 
> As you see it is more or less what I have already written for my tests.
> I only don't check if /objects and /refs are directories. If you want I
> can send proper patch submission for this function

I don't know how strict we should be, but "/objects" and "/refs" are just
one stat more.


Anyway, if you plan on resending this patch series, then "gitweb: Improve
repository verification" should be be first, I think.

-- 
Jakub Narebski
Poland
