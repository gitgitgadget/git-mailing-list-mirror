From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Mon, 2 Apr 2012 19:20:22 +0200
Message-ID: <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
References: <7viphov839.fsf@alter.siamese.dyndns.org> <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org> <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org> <20120329054558.GA27604@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 02 19:21:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEkwI-0000IJ-1V
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 19:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab2DBRVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 13:21:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45139 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112Ab2DBRVD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 13:21:03 -0400
Received: by pbcun15 with SMTP id un15so4647437pbc.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=s0d1GUbrA/GMk/Z/2HVVPhYFe8KfqlZw6bsb559gLZ0=;
        b=0eQOXZHbWqz2vqX51JDkpXpoXU5mI0ysQKuviPP3JKnaMuVdt28CEykP3nLI61nAZz
         ruv4QZRTYvUxhisAsX0M8CCpaH9RFI2uik0AjfWF39UH5eGFUdBmdmz55B8OgLzhlHtb
         NGZV3R3HOchvFlt8MVcYAn+QQ9Z1aO8PdOdVAXAsL7foQN1ZvIfVgcSmTIOBRkU1yzB+
         mlUhDc5+4ALF0Bhk5Rs3eZM1A9zlMx9kOM4SrIL/v60YBMlnLJlPq3jaE/b1Fw/trX3m
         i+vQpqO495rKxvQKrTwzMRzxcREOquTeSxFawf31qwwQusOAwLF0LfkuAvJBCuzkPSDM
         pLWA==
Received: by 10.68.197.65 with SMTP id is1mr21996888pbc.70.1333387262720; Mon,
 02 Apr 2012 10:21:02 -0700 (PDT)
Received: by 10.68.136.40 with HTTP; Mon, 2 Apr 2012 10:20:22 -0700 (PDT)
In-Reply-To: <20120329054558.GA27604@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194542>

On Thu, Mar 29, 2012 at 7:45 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 28, 2012 at 03:14:31PM -0700, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> >> Totally untested, but something along this line...
>> >
>> > Well, probably along that line but not there. =A0I think the patch=
 would be
>> > a lot cleaner to keep the part I touched intact, and instead add a=
n extra
>> > "ls-files -u" that creates %unmerged hash in the way this patch do=
es,
>> > immediately before the last for() loop in the function. =A0And the=
n the loop
>> > can use %unmerged hash to filter the elements.
>>
>> That is, something like this.
>
> That is way better. Your original one would end up putting every file=
 in
> the repo into @tracked, which would then be fed on the command-line t=
o
> "diff-index" and company. I suspect on a large repo that could overfl=
ow
> the command-line limits (plus I recall that at one point we performed
> way worse on "git diff $(git ls-files)" than we do on "git diff", but
> that may not be the case anymore).
>
> However, I can think of two possible improvements:
>
>> + =A0 =A0 my %unmerged;
>> + =A0 =A0 if ($filter_unmerged) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (run_cmd_pipe(qw(git ls-files -u --), =
@ARGV)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chomp $_;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (/^[0-7]+ [0-9a-f]{40} =
[0-3] (.*)/) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $path =3D=
 unquote_path($1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $unmerged{=
$path} =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (%unmerged) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (sort keys %unmerged) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print colo=
red $error_color, "ignoring unmerged: $_\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>
> I like that we are down to a single ls-files invocation here. But can=
't
> we determine from the diff-files output whether an entry is unmerged.=
 In
> my simple tests, I see that --numstat will show two lines for such an
> entry. Is that reliable?
>

Nice. I've observed the same thing (although I've seen three entries,
not two). I don't know about the reliability, but I think it kind of
makes sense; one entry for both parents, and one for the unmerged
working-copy version.

Junio, what do you think?

>> =A0sub patch_update_cmd {
>> - =A0 =A0 my @all_mods =3D list_modified($patch_mode_flavour{FILTER}=
);
>> + =A0 =A0 my @all_mods =3D list_modified($patch_mode_flavour{FILTER}=
, 'filter-unmerged');
>> =A0 =A0 =A0 my @mods =3D grep { !($_->{BINARY}) } @all_mods;
>
> It seems like a more flexible interface would not be to filter unmerg=
ed
> entries, but rather to mark them as we do with BINARY. And then the
> caller can do as they please, discarding, printing warnings, etc.
>
> Right now, the behavior is to simply skip them. But it would be cool =
if
> we could eventually show a useful presentation of the changes and ask=
 to
> stage them. I know from our past discussions it is not quite as feedi=
ng
> the combined diff to the regular hunk-selector. But I'm sure we can c=
ome
> up with something reasonable.
>
> Here's the patch that I came up with to do both of those things. Like=
 I
> said, I am somewhat unsure of the "detect double mentions as unmerged=
"
> rule. But we could still use the "ls-files -u" output to mark the
> unmerged files.
>
> ---
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 8f0839d..6204207 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -336,7 +336,14 @@ sub list_modified {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$chang=
e =3D "+$add/-$del";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $data{$file}{FILE} =3D =
$change;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # If we see it twice, i=
t's unmerged.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (defined $data{$file=
}{FILE} &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $data{$file}{FI=
LE} ne 'nothing') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $data{$=
file}{FILE} =3D 'unmerged';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $data{$=
file}{FILE} =3D $change;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ($bin) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$data{=
$file}{BINARY} =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -1193,6 +1200,10 @@ sub patch_update_cmd {
> =A0 =A0 =A0 =A0my @mods =3D grep { !($_->{BINARY}) } @all_mods;
> =A0 =A0 =A0 =A0my @them;
>
> + =A0 =A0 =A0 print colored $error_color, "ignoring unmerged: $_->{VA=
LUE}\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for grep { $_->{FILE} eq 'unmerged' } @=
mods;
> + =A0 =A0 =A0 @mods =3D grep { $_->{FILE} ne 'unmerged' } @mods;
> +
> =A0 =A0 =A0 =A0if (!@mods) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (@all_mods) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print STDERR "Only bin=
ary files changed.\n";

I like both the result and the flexibility. There's one minor nit,
though: Now "git add -i" says "Only binary files changed.", which
isn't true. But this is a simple matter of updating the warning to
something like "Only binary or unmerged files changed.".
