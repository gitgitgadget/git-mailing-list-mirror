From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: post-receive-hook emailer
Date: Tue, 22 Jul 2008 16:10:22 +0530
Message-ID: <20080722104022.GA6621@toroid.org>
References: <00AEED4D-BD34-4584-B303-32C5F587EF0F@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ask =?iso-8859-1?Q?Bj=F8rn?= Hansen <ask@develooper.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 12:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLFJ7-0007P4-DT
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 12:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbYGVKk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 06:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbYGVKk0
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 06:40:26 -0400
Received: from fugue.toroid.org ([85.10.196.113]:60529 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbYGVKkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 06:40:25 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 07E91558223;
	Tue, 22 Jul 2008 12:40:24 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 26DFCADC364; Tue, 22 Jul 2008 16:10:23 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <00AEED4D-BD34-4584-B303-32C5F587EF0F@develooper.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89483>

Hi Ask.

At 2008-07-22 02:34:35 -0700, ask@develooper.com wrote:
>
> Anyway - anyone have a mailer that sends diffs and such? :-)

Not quite what you want, but I wrote the attached post-receive hook/hack
to send change notifications by Jabber. "hooks.notify.recipients" should
contain a list of jabber IDs; and you can change the "git log" line, for
example by adding "-p --stat" or something, to change what gets sent.

It should be trivial to change the last twenty-odd lines to send email
instead.

-- ams

#!/usr/bin/perl
# Abhijit Menon-Sen <ams@oryx.com>

use Net::Jabber;

my $dir;
chomp( $dir = qx(git rev-parse --git-dir 2>/dev/null) );
die "GIT_DIR not defined.\n" unless $dir;
$ENV{GIT_DIR} = $dir;

my $r;
chomp( $r = qx(git config hooks.notify.recipients) );
my @recipients = split /,\s*/, $r;

my @changes;
while ( <> ) {
    chomp;
    my ( $old, $new, $ref ) = split / /;
    $ref =~ s!refs/heads/!!;
    next unless $ref eq "some/branch";
    my $s = qx(git log --no-merges --reverse --find-copies-harder --raw -r $old..$new);
    $s =~ s/^:.*?\t/\t/gsm;
    push @changes, $s;
}

exit unless @changes;
exit unless @recipients;

my $client = new Net::Jabber::Client ();
$client->Connect(
    hostname => 'example.com',
) or die "Cannot connect to jabber server: $!.\n";

my @r = $client->AuthSend(
    username => 'git',
    password => 'some-password',
    resource => 'git'
);
die "Cannot authenticate (@r).\n" if $r[0] ne "ok";

foreach my $c (@changes) {
    for my $r (@recipients) {
        my $msg = new Net::Jabber::Message ();
        $msg->SetMessage(
            to => $r,
            subject => 'Changes pushed to x:y.git/some/branch',
            body => $c
        );
        $client->Send( $msg );
    }
}

$client->Disconnect();
