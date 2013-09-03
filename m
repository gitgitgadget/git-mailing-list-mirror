From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: contrib/credential/netrc/git-credential-netrc: Use of uninitialized value in string
Date: Tue, 03 Sep 2013 11:23:14 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87k3iyhqu5.fsf@lifelogs.com>
References: <CALWbr2ynAvevTxFd3duAfFzgv0DCGTDxFUaniW-8hM+eoLiOEw@mail.gmail.com>
	<xmqqr4dfhjmg.fsf@gitster.dls.corp.google.com>
	<20130827200550.GA17443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 17:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGsSE-0005P5-1b
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 17:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab3ICPXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 11:23:35 -0400
Received: from plane.gmane.org ([80.91.229.3]:40841 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729Ab3ICPXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 11:23:34 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VGsS3-0005Kv-Ha
	for git@vger.kernel.org; Tue, 03 Sep 2013 17:23:31 +0200
Received: from c-98-229-61-72.hsd1.ma.comcast.net ([98.229.61.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 17:23:31 +0200
Received: from tzz by c-98-229-61-72.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 17:23:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-229-61-72.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:e3l3vlzjtlgjg9PdY+oI6CQleyQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233729>

On Tue, 27 Aug 2013 16:05:51 -0400 Jeff King <peff@peff.net> wrote: 

JK> On Mon, Aug 26, 2013 at 08:56:23PM -0700, Junio C Hamano wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>> 
>> > I've tried to use the netrc credential with git-send-email
>> > (v1.8.4-rc2), and I've had the following log (running with -d -v):
>> 
>> Peff what do you think?  From credential layer's point of view, I
>> think we make it totally up to the helper to decide if a request
>> matches what it supports, and if a particular helper wants to make
>> sure it is asked for a specific protocol, that is an OK thing to do,
>> but it feels unnecessarily unfriendly and treating missing proto
>> specification as a wildcard to talk to the specified host over any
>> protocol may not hurt, I would think.

JK> Right. It is up to the credential helper to map git's request into
JK> whatever storage it has. So I think the right answer is whatever is
JK> normal and expected for netrc.

JK> Unfortunately that is not really a standardized format. The original
JK> netrc was ftp-only, and did not have a port or protocol field at all.
JK> Programs like curl extend it automatically to http, and just googling
JK> around seems to show other programs using it for imap and smtp. So I
JK> think there is some precedence in simply treating a missing "port" field
JK> as "match any port/protocol" on the machine.

JK> The upside is that it is convenient for the user. The downside is that
JK> we might accidentally send a password to a service that the user does
JK> not expect, which could compromise security. It would at least be on the
JK> matching host, but the protocol might not be as secure as the one the
JK> user intended (e.g., smtp without starttls, when the password was meant
JK> to only go over imap-over-ssl).

This gets tricky, certainly.  I'd rather make it convenient because
users will, anyway.

JK> So I'm on the fence. It is very unlikely to be a bad thing, but if it
JK> is, it may expose user passwords in cleartext. If we are going to keep
JK> the current behavior, it probably needs to be documented

I'm OK with treating missing protocols as wildcards.

JK> and certainly:

>> > Use of uninitialized value $_[2] in printf at
>> > /home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
>> > line 419.
>> > compare protocol [] to [smtp] (entry: password=secret,
>> > username=apelisse@gmail.com, host=smtp.gmail.com:587)
>> > Use of uninitialized value in string eq at
>> > /home/antoine/code/git/contrib/credential/netrc/git-credential-netrc
>> > line 378.

JK> ...these should more cleanly handle the missing field.

Yes, you're right.  Something like the following (untested) could work
and does the wildcards, which I will make into a proper patch and test
if it looks OK to you.

Ted

diff --git a/contrib/credential/netrc/git-credential-netrc b/contrib/credential/netrc/git-credential-netrc
index 6c51c43..13e537b 100755
--- a/contrib/credential/netrc/git-credential-netrc
+++ b/contrib/credential/netrc/git-credential-netrc
@@ -369,7 +369,10 @@ sub find_netrc_entry {
        {
                my $entry_text = join ', ', map { "$_=$entry->{$_}" } keys %$entry;
                foreach my $check (sort keys %$query) {
-                       if (defined $query->{$check}) {
+                       if (!defined $entry->{$check}) {
+                              log_debug("OK: entry has no $check token, so any value satisfies check $check");
+                       }
+                       elsif (defined $query->{$check}) {
                                log_debug("compare %s [%s] to [%s] (entry: %s)",
                                          $check,
                                          $entry->{$check},
