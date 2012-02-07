From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Deal with HEAD pointing to unborn branch in "heads" view
Date: Tue, 7 Feb 2012 17:53:11 +0100
Message-ID: <201202071753.12436.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201202032233.05324.jnareb@gmail.com> <CA+EqV8w6k2VrEtMydhGKZHbQdXHxCE3WA_0rtS-AY4cmQvii=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: rajesh boyapati <boyapatisrajesh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 17:53:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuoIJ-00086o-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 17:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab2BGQxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 11:53:17 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36306 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969Ab2BGQxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 11:53:16 -0500
Received: by eaah12 with SMTP id h12so2889378eaa.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Ov935Emx7tsw80S4OBQ3cw0k6jfQ4IWUOTS2GpPdGkk=;
        b=XirBnauG0zPOucWCUkepPq7NUAyQP2m5pX0rSVCcxB2N19Bl95eriIacybvrRMwHii
         ZUJn1CUgzJuL193FIURHIDXOKtYL12GL86wUlHHidIRLPf/huBUaSyMeAEGLgynXmlyY
         7ia4+Au6Ptp0aUj49vdkpqknCi29ufJeR9U+A=
Received: by 10.213.21.6 with SMTP id h6mr2164666ebb.131.1328633595121;
        Tue, 07 Feb 2012 08:53:15 -0800 (PST)
Received: from [192.168.1.13] (abwl246.neoplus.adsl.tpnet.pl. [83.8.235.246])
        by mx.google.com with ESMTPS id v51sm11837385eef.2.2012.02.07.08.53.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 08:53:14 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8w6k2VrEtMydhGKZHbQdXHxCE3WA_0rtS-AY4cmQvii=A@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190183>

On Mon, 6 Feb 2012, rajesh boyapati wrote:
> 
> Thanks for your work.

I'm sorry I was able to find a fix only for the part of issue.

>>>>>>>>> [2012-01-25 18:50:35,658] ERROR
>>>>>>>>> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Wed Jan 25
>>>>>>>>> 18:50:35 2012] gitweb.cgi: Use of uninitialized value $commit_id
>>>>>>>>> in open at /usr/lib/cgi-bin/gitweb.cgi line 2817.
>>>>>>>
>>>>>>> sub parse_commits {
>>>>>>>     my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
>>>>>>>     my @cos;
>>>>>>>
>>>>>>>     $maxcount ||= 1;
>>>>>>>     $skip ||= 0;
>>>>>>>
>>>>>>>     local $/ = "\0";
>>>>>>>
>>>>>>>     open my $fd, "-|", git_cmd(), "rev-list",
>>>>>>>         "--header",
>>>>>>>         @args,
>>>>>>>         ("--max-count=" . $maxcount),
>>>>>>>         ("--skip=" . $skip),
>>>>>>>         @extra_options,
>>>>>>>         $commit_id,
>>>>>>>         "--",
>>>>>>>         ($filename ? ($filename) : ())
>>>>>>>         or die_error(500, "Open git-rev-list failed");
>>
>> But I was not able to fix this, at least not currently.  I wrote a failing
>> test case for "commit" and similar views on unborn HEAD... but they fail
>> _without_ error message like the one quoted.
>>
>> I'd have to go slower route of examining gitweb code in how it deals with
>> "invalid" HEAD (i.e. HEAD not pointing to commit, being on unborn branch).

[...]
>> And here is the patch:
>> -->8 ------------>8 ---
>> From: Jakub Narebski <jnareb@gmail.com>
>> Subject: [PATCH] gitweb: Deal with HEAD pointing to unborn branch in
>>   "heads"  view
[...]
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 9cf7e71..1f0ec12 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -5570,7 +5570,7 @@ sub git_tags_body {
>>
>>  sub git_heads_body {
>>        # uses global variable $project
>> -       my ($headlist, $head, $from, $to, $extra) = @_;
>> +       my ($headlist, $head_at, $from, $to, $extra) = @_;
>>        $from = 0 unless defined $from;
>>        $to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
>>
> 
> I didn't see a file called "gitweb.perl" in /usr/share/gitweb/

The file "gitweb.perl", or rather "gitweb/gitweb.perl" is the name
of the script in git.git repository.  From it "make gitweb" would
generate "gitweb.cgi" file...

> I applied this patch to file "index.cgi" in /usr/share/gitweb/index.cgi at
> line 4711.
[...]
> 
> I applied this patch to file "index.cgi" in /usr/share/gitweb/index.cgi at
> line 4720.


...and I guess Gerrit build process generates "index.cgi" from that.

> Had I applied the patch to the correct file "index.cgi", which is a link to
> file "gitweb.cgi" in /usr/lib/cgi-bin/gitweb.cgi ?

Ah, right.

> Then, I restarted gerrit server to take changes.
> Now the error log of gerrit shows:

> [2012-02-06 11:21:46,726] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision
> 'HEAD'
> [2012-02-06 11:21:49,167] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: [Mon Feb  6 11:21:49
> 2012] gitweb.cgi: Use of uninitialized value $commit_id in open at
> /usr/lib/cgi-bin/gitweb.cgi line 2817.
> [2012-02-06 11:21:49,169] ERROR
> com.google.gerrit.httpd.gitweb.GitWebServlet : CGI: fatal: bad revision ''
[the same errors repeated few times]

> <<<<<<<<<<<<<<<<
> Previously, there is a error showing at line 4720. Now, with this patch,
> that error has gone.

As I said I was able to find a fix only for part of the issue.  
Unfortunately I was not able to reproduce this error in this form.
Note that the error location doesn't help much, because it is more
interesting for find which callers of parse_commits() pass undefined
$commit_id.

I can try to harden parse_commits() against bogus parameters; maybe
this would help.
 
> I tried to upgrade gitweb with the command "sudo apt-get install gitweb",
> but, it didn't find any upgrade.
> Am I doing in a right way?

There is no new version of gitweb yet; it haven't even been accepted
by Junio Hamano, maintainer of git of which gitweb is part, into git
repository (I might have to resend this patch for better visibility).

> Is there any place like "Github" (where we can place git projects) for
> gitweb ?

Gitweb is for quite some time developed within git repository.  From
it the 'gitweb' package is created.

Clones of canonical, official git repository can be found in a few places:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

My own clone of git, with my work, can be found at:

       git://repo.or.cz/git/jnareb-git.git
       https://github.com/jnareb/git

>> diff --git a/t/t9500-gitweb-standalone-no-errors.sh
>> b/t/t9500-gitweb-standalone-no-errors.sh
>> index 0f771c6..81246a6 100755
>> --- a/t/t9500-gitweb-standalone-no-errors.sh
>> +++ b/t/t9500-gitweb-standalone-no-errors.sh
>> @@ -739,4 +739,13 @@ test_expect_success \
>>        'echo "\$projects_list_group_categories = 1;">>gitweb_config.perl
>> &&
>>         gitweb_run'
>>
>> +# ----------------------------------------------------------------------
>> +# unborn branches
>> +
>> +test_expect_success \
>> +       'unborn HEAD: "summary" page (with "heads" subview)' \
>> +       'git checkout orphan_branch || git checkout --orphan orphan_branch
>> &&
>> +        test_when_finished "git checkout master" &&
>> +        gitweb_run "p=.git;a=summary"'
>> +
>>  test_done
>>
> 
> I didn't find a file where to apply this patch.
> Is this file to test your patch for you?

Yes, this is to test that my patch fixes the issue correctly, and to
ensure that further changes don't re-break it.  It is not usually
installed with git or gitweb, so don't worry about it.

-- 
Jakub Narebski
Poland
