From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Sun, 19 Sep 2010 07:39:11 +0200
Message-ID: <AANLkTinkikwt5cUxuXECfeQrKZthu271U82F3ebSrEmd@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com> <201009171854.03476.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 07:39:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxCcl-00066u-Qz
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 07:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab0ISFjd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 01:39:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49490 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0ISFjc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 01:39:32 -0400
Received: by iwn5 with SMTP id 5so3224676iwn.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 22:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kaczLhIDpG2H6pLQ6ZFdWIVBASbcJTQsebi06B7Unug=;
        b=avfs+Cnxyi6ZhiYSvAGSeHKJefGt+TuDl+M4B7VcGCBOkNqRRxrDyx1mxR1qTzezs4
         IZBJSPtw0MHXJo0xw1T8i413LquiU5LWOET/cy/7TX0Ksi9oN0My0DkH7P+E/rf2yuE2
         EuB0/ddNA5g0+VdEt2B+O+NBpk5fMedmiVzDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fCtZeLs8R53c4Bp75GeBJ2r1dNgDZf/UVAJfd8o2UycVC800uy4+uXGgZ42aWxgUH4
         j1/2YSKnrwIPLq1S040V+1xLBqWZSBSU/Wyxh4qeH4VbGkUQ99JC95+9QUhJdFlYoooF
         aJXJuu6HMz+iPX+CpOI9+tU+V7imlNUwXV0+E=
Received: by 10.231.11.4 with SMTP id r4mr7879436ibr.66.1284874771246; Sat, 18
 Sep 2010 22:39:31 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Sat, 18 Sep 2010 22:39:11 -0700 (PDT)
In-Reply-To: <201009171854.03476.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156485>

Hello,

as I mentioned, this patch was the one I had most doubts about. I will
therefore skip over the stylistic suggestions (which I _am_ following
for the next release of this patchset) and only reply to the more
technical remarks.

On Fri, Sep 17, 2010 at 6:54 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 92551e4..66b5400 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2758,6 +2758,16 @@ sub git_get_last_activity {
>> =A0 =A0 =A0 return (undef, undef);
>> =A0}
>>
>> +sub git_get_remotes {

[snip]

>> + =A0 =A0 my @remoteheads =3D git_get_heads_list($limit, 'remotes');
>> + =A0 =A0 return (\@remotes, \@remoteheads);
>
> Why do you want for git_get_remotes() to also return remote-tracking
> branches (refs/remotes/)? =A0Those are separate issues, and I think i=
t
> would be better API for git_get_remotes() to provide only list of
> remotes, i.e.
>
> =A0+ =A0 =A0 return @remotes;
>
> Especially that we might want in the summary view to only list remote=
s,
> without listing remote-tracking branches.
>
> That would require more changes to the code.

This is kind of the main issue with this patch. What do we want to do
with the remotes list in summary view and the remotes view? We
basically have three possibilities:

(1) we can make the remotes list in summary view be a 'reduced
remotes' view: this would make it behave the most similarly to the
other components of summary view
(2) we can make the remotes list be much more stripped down, by only
listing the remotes and possibly some summarizing property such as the
number of branches in it or when it was last updated
(3) we can make the remotes list be just a copy of the full remotes vie=
w.

The third option is surely the easiest to implement. The second option
with _only_ a list of remotes (no extra info) is also very easy to
implement _and_ fast to render. The second option with extra info, or
the first option, on the other hand, require the retrieval of some
additional data which, maybe due to my limited knowledge of git,
essentially means retrieving _all_ the remote heads and then doing the
filtering in gitweb. But once we're getting all the information, why
not display it all? isn't it faster to just display all of it, in
which case we go back to option 3?

If we go with option 3, it does make sense to get all remote names and
all remote branches at once, and thus to make the git_get_remotes()
call do all of the work.

>> +}
>> +
>> =A0sub git_get_references {
>> =A0 =A0 =A0 my $type =3D shift || "";
>> =A0 =A0 =A0 my %refs;
>> @@ -4979,7 +4989,7 @@ sub git_heads_body {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<td class=3D\"link\">" .
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cgi->a({-href =3D> href(act=
ion=3D>"shortlog", hash=3D>$ref{'fullname'})}, "shortlog") . " | " .
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cgi->a({-href =3D> href(act=
ion=3D>"log", hash=3D>$ref{'fullname'})}, "log") . " | " .
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cgi->a({-href =3D> href(actio=
n=3D>"tree", hash=3D>$ref{'fullname'}, hash_base=3D>$ref{'name'})}, "tr=
ee") .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $cgi->a({-href =3D> href(actio=
n=3D>"tree", hash=3D>$ref{'fullname'}, hash_base=3D>$ref{'fullname'})},=
 "tree") .
>
> This is independent change, and should be in a separate commit, isn't=
 it?

Probably yes, with an explanation of the why.

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "</td>\n" .
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "</tr>";
>> =A0 =A0 =A0 }
>> @@ -4991,6 +5001,19 @@ sub git_heads_body {
>> =A0 =A0 =A0 print "</table>\n";
>> =A0}
>>
>> +sub git_remotes_body {
>> + =A0 =A0 my ($remotedata, $head) =3D @_;
>> + =A0 =A0 my @remotenames =3D @{$remotedata->[0]};
>> + =A0 =A0 my @allheads =3D @{$remotedata->[1]};
>
> Why not
>
> =A0+ =A0 =A0 my ($remotenames, $allheads, $head) =3D @_;
>
> Beside, isn't it $remote_heads and not $allheads?

I think it's a leftover name choice from the first version of the
patch. Can change.

>> + =A0 =A0 foreach my $remote (@remotenames) {
>
> It would be then
>
> =A0+ =A0 =A0 foreach my $remote (@$remotenames) {
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 my @remoteheads =3D grep { $_->{'name'} =3D=
~ s!^\Q$remote\E/!! } @allheads;
>
> Should we display remote even if it doesn't have any remote heads
> associated with it?
>
> By the way, it would be place where we could limit number of
> remote-tracking branches displayed in each remote block.

But does it make sense to reduce the number of displayed branches
after we got the information about all of them? I think it depends on
what summary view is intended to do exactly.

>> + =A0 =A0 =A0 =A0 =A0 =A0 git_begin_group("remotes", $remote, "remot=
es/$remote",$remote);
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_heads_body(\@remoteheads, $head);
>> + =A0 =A0 =A0 =A0 =A0 =A0 git_end_group();
>
> This would have to be modified with change to git_begin_group() /
> / git_end_group().

Of course.

> BTW isn't it premature generalization? =A0It is only place AFAIKS tha=
t
> uses git_*_group() subroutines.

It's the only current use but I believe that, since it's factored out
now already and since it may be used in other views too (think:
grouping heads or tags by prefix) it might make sense to keep it this
way.

>> + =A0 =A0 }
>> +
>> +}
>> +
>> =A0sub git_search_grep_body {
>> =A0 =A0 =A0 my ($commitlist, $from, $to, $extra) =3D @_;
>> =A0 =A0 =A0 $from =3D 0 unless defined $from;
>> @@ -5137,7 +5160,7 @@ sub git_summary {
>> =A0 =A0 =A0 # there are more ...
>> =A0 =A0 =A0 my @taglist =A0=3D git_get_tags_list(16);
>> =A0 =A0 =A0 my @headlist =3D git_get_heads_list(16, 'heads');
>> - =A0 =A0 my @remotelist =3D $remote_heads ? git_get_heads_list(16, =
'remotes') : ();
>> + =A0 =A0 my @remotelist =3D $remote_heads ? git_get_remotes(16) : (=
);
>
> No change of git_get_remotes() does only one thing: returning list
> of remotes.

See above about what should git_get_remotes() do. Even better, I was
thinking about git_get_remotes() returning a hash (mapping remote
names to the heads from that remote)

So the big question (which essentially determines the functionality
provided by this last patch in the set) is: what do we want to do in
summary view?

--=20
Giuseppe "Oblomov" Bilotta
