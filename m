From: Ammon Riley <ammon.riley@gmail.com>
Subject: Re: [PATCH] Allow fancy globs in git-svn init branches
Date: Tue, 18 Sep 2012 15:56:10 -0700
Message-ID: <CAMvPOPuCW-oCfV8pyN3OMU3barFsSX2pHgr4K4Og7GOnFiU-7Q@mail.gmail.com>
References: <1347925598-23907-1-git-send-email-ammon.riley@gmail.com>
	<20120918204654.GA22856@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, marcin@owsiany.pl, schwern@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:56:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE6iK-00012h-2B
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 00:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab2IRW4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 18:56:12 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:46636 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab2IRW4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 18:56:10 -0400
Received: by ieak13 with SMTP id k13so604500iea.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VNgB1OV5bcXwcbuOfzeR5rX784YOnufWzGRZcVUNm1c=;
        b=THgHGCloS94IoCPUqkPZ7W/VyzoF7YBFjtennAM/YxGc5O1Vyks69eeyBqNWktSh4Q
         Y51GSeoOOmfIi0nq/yAl/uHguptYLR+fU6v2h4gfVeDfka5KUSVFi+EaUIwPCyFVWhBj
         mkOlbbkYX03fbTxn1BZKPof1JLtPvHz+TyKia7zAcIW5/9Xgp6PsGv6kFyiPoQVyu0af
         sKgxh9ssqKpkGXkW9sBi95FvJkPv04DyE0G0Mp9Fx7yQg4VVrMU3jdX65KGnGwnhj8pK
         WgfkfL1uH4KhGzuZH/v/MGUdiRALdBsg5nlOyFOQqT2vx7D9pKzucSuWDXDY5wlCPLey
         0/9g==
Received: by 10.50.160.202 with SMTP id xm10mr1437597igb.10.1348008970309;
 Tue, 18 Sep 2012 15:56:10 -0700 (PDT)
Received: by 10.42.159.132 with HTTP; Tue, 18 Sep 2012 15:56:10 -0700 (PDT)
In-Reply-To: <20120918204654.GA22856@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205884>

On Tue, Sep 18, 2012 at 1:46 PM, Eric Wong <normalperson@yhbt.net> wrote:
> Ammon Riley <ammon.riley@gmail.com> wrote:
>> Branches passed to 'git-svn init' via the -b/--branches flag
>> automatically had a /* appended to them.  When the branch contained
>> a fancy glob with a {} pattern, this is incorrect behaviour, and
>> leads to odd branches being created in the git repository.
>>
>> Signed-off-by: Ammon Riley <ammon.riley@gmail.com>
>> ---
>>  git-svn.perl                         |  2 +-
>>  t/t9141-git-svn-multiple-branches.sh | 12 ++++++++++++
>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 0d77ffb..f8e8558 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -1678,7 +1678,7 @@ sub complete_url_ls_init {
>>       my $remote_path = join_paths( $gs->path, $repo_path );
>>       $remote_path =~ s{%([0-9A-F]{2})}{chr hex($1)}ieg;
>>       $remote_path =~ s#^/##g;
>> -     $remote_path .= "/*" if $remote_path !~ /\*/;
>> +     $remote_path .= "/*" if $remote_path !~ m#\*|\{[^/]+\}#;
>>       my ($n) = ($switch =~ /^--(\w+)/);
>>       if (length $pfx && $pfx !~ m#/$#) {
>>               die "--prefix='$pfx' must have a trailing slash '/'\n";
>> diff --git a/t/t9141-git-svn-multiple-branches.sh b/t/t9141-git-svn-multiple-branches.sh
>> index 3cd0671..1b872a9 100755
>> --- a/t/t9141-git-svn-multiple-branches.sh
>> +++ b/t/t9141-git-svn-multiple-branches.sh
>> @@ -119,4 +119,16 @@ test_expect_success 'create new branches and tags' '
>>               svn_cmd up && test -e tags_B/Tag2/a.file )
>>  '
>>
>> +test_expect_success 'clone multiple branch paths using fancy glob' '
>> +     git svn clone -T trunk \
>> +                   -b b_one/{first} --branches b_two \
>
> I'm concerned encouraging this can cause confusion on the command-line
> for bash users.
>
> In bash, "b_one/{first}" will be passed as-is (and hardly anybody
> will have a repo with '{word}' in the path)
>
> However, unless quoted on the command-line, a likely case of:
> "b_one/{first,second}" will expand to: "b_one/first" "b_one/second"
>
> ...which causes "b_one/second" to be interpreted as the destination
> directory.   A knowledgeable bash user can avoid this by using:
> -b=b_one/{first,second} to avoid this situation.
>
> But with the above invocation, no explicit support is needed
> for command-line parsing in git-svn.

I confess that I'd completely forgot about the {} expansion in bash.
Perhaps a note in the CAVEATS section of the documentation would
be sufficient?

As a bit of background on the reason for this patch, the branches
in our repository are set up under svnroot as:

    <project>/releases/<branchName>/<branchName>/

I have no idea why.  So I end up with an init line like so:

    git svn init -T trunk -b 'releases/release_7_0/{release_7_0}' \
                          -b 'releases/release_7_1/{release_7_1}' \
                          http://server/svnroot/myProj

This, unfortunately, prevents me from using the shorter {A,B}
notation, so I didn't test that.
