From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Add a feature for adding more branch refs
Date: Tue, 3 Dec 2013 21:38:07 +0100
Message-ID: <CANQwDwcpkbbfND9MmB9wGcL7mrhV_Mxb1amvGPgWeR344_fcfw@mail.gmail.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
 <1386082603-8404-3-git-send-email-krzesimir@endocode.com> <xmqqr49tn11c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 21:38:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnwk8-0006jI-Ue
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab3LCUis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 15:38:48 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:60033 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022Ab3LCUis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:38:48 -0500
Received: by mail-wi0-f177.google.com with SMTP id cc10so7170568wib.4
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 12:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DqqZueLIpXVMeKh2uJdFWvemwA4jnq7fjZVaN5d01rI=;
        b=HaHoSZPr7/vcqSx1Khdtqe6oBa9g42wpwB3xPjGy4Tmi9l9lSXpy8oPTp/cnGrEquZ
         6iF94RDwbmyikvbwFhnNomm+ibgyZmmG3fgzlQJB7j6KLk0ykbM6PoNnHX9WZ5AvYuc/
         1s8p8gFG8iyBn00QYWh1KohjvAlDqXF8eCpKgQxW5ZJYI3fzwLFHTPzfBlSzblii+jQ1
         M5ECQ1XntLOjuZnzA76tl9j2E5d7SI/jV+rosnk+aRxAkWbRRaOo+OJaYWNrWMDftQi/
         A3yWfRZ3AMHb5T6/D+vqHzwhh3Y8dblyOQdhHmeNwK0DfytzSx4suOPhANFYFZZWoTCB
         03zg==
X-Received: by 10.180.106.41 with SMTP id gr9mr4206353wib.41.1386103127220;
 Tue, 03 Dec 2013 12:38:47 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Tue, 3 Dec 2013 12:38:07 -0800 (PST)
In-Reply-To: <xmqqr49tn11c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238735>

On Tue, Dec 3, 2013 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Krzesimir Nowak <krzesimir@endocode.com> writes:
>
>> @@ -626,6 +640,17 @@ sub feature_avatar {
>>       return @val ? @val : @_;
>>  }
>>
>> +sub feature_extra_branch_refs {
>> +     my (@branch_refs) = @_;
>> +     my $values = git_get_project_config('extra_branch_refs');
>
> Hmph.  Three points.
>
> * Almost all callers of this function use
>
>     my ($val) = git_get_project_config(...);
>     my @val = git_get_project_config(...);
>
>   to expect that the function returns a list of things (and grab the
>   first one among them, not the length of the list).  Shouldn't this
>   part do the same?

Right. feature_snapshot() has here

    my (@fmts) = @_;
    my ($val) = git_get_project_config('snapshot');

...though git_get_project_config returns scalar.

> * Wouldn't this be a good candidate for a multi-valued configuration
>   variable, e.g. shouldn't this
>
>         [gitweb]
>                 extraBranchRefs = wip
>                 extraBranchRefs = sandbox other
>
>   be parsed as a three-item list, qw(wip sandbox other)?

This would require changes in git_get_project_config(), which would
need to be able to deal with multi-valued result (it caches these
results, so we pay only one cost of `git config` call).

> * I think the $key parameter to git_get_project_config() eventually
>   is used to look up a key in the Git-style configuration file, and
>   the 'words_with_underscore' goes against our convention (cf. see
>   how 'show-sizes' feature is spelled as 'showsizes' there).

Errr... actually git_get_project_config() strips '_' from $key, though
not for some strange reason '-'.

BTW. though it is 'showsizes' in code, it usually is 'showSizes' in
config file (camelCase convention, lowercased by git-config).

>> +     if ($values) {
>> +             @branch_refs = split /\s+/, $values;
>> +     }
>> +
>> +     return @branch_refs;
>> +}



-- 
Jakub Narebski
