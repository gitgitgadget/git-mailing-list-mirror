X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make RSS feed output prettier
Date: Wed, 15 Nov 2006 01:24:23 +0100
Organization: At home
Message-ID: <ejdmlb$77s$1@sea.gmane.org>
References: <11635494363452-git-send-email-asf@boinkor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 15 Nov 2006 00:23:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 70
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31394>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk8Ys-0005yL-IY for gcvg-git@gmane.org; Wed, 15 Nov
 2006 01:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966523AbWKOAX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 19:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966524AbWKOAX1
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 19:23:27 -0500
Received: from main.gmane.org ([80.91.229.2]:22464 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966523AbWKOAX0 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 19:23:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gk8Yf-0005va-00 for git@vger.kernel.org; Wed, 15 Nov 2006 01:23:17 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 01:23:16 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 15 Nov 2006
 01:23:16 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Fuchs <asf@boinkor.net> wrote:

> * Wrap the commit message in <pre>
We use <div class="pre"> in "commit" view if I remember correctly.

> * Make file names into an unordered list
Good idea.

> * Add links (diff, conditional blame, history) to the file list.
I'd rather keep RSS output as simple as possible, no frills.

> ---
>  gitweb/gitweb.perl |   22 ++++++++++++++++------
>  1 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e54a29e..2a79895 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4134,20 +4134,30 @@ XML
>                     "<content:encoded>" .
>                     "<![CDATA[\n";
>               my $comment = $co{'comment'};
> +             print "<pre>\n";
>               foreach my $line (@$comment) {
> -                     $line = to_utf8($line);
> -                     print "$line<br/>\n";
> +                     $line = to_utf8(esc_html($line));
esc_html does to_utf8, so to_utf8 is unnecessary (and spurious).
But it is a good catch: esc_html is certainly needed.

> +                     print "$line\n";
>               }
> -             print "<br/>\n";
> +             print "</pre><ul>\n";
>               foreach my $line (@difftree) {
>                       if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
>                               next;
>                       }
> -                     my $file = esc_path(unquote($7));
> +                     my $file_name = unquote($7);
> +                     my $file = esc_html($file_name);
We have introduced esc_path for escaping pathnames. Use it!

> +                     my $parent = $co{'parent'};
> +                     my $hash = git_get_hash_by_path($commit, $file_name);
> +                     my $hashparent = git_get_hash_by_path($parent, $file_name);
Two unnecessary calls to git command. Use 
     my %difftree = parse_difftree_raw_line($line)
instead. The conditions would probably be 
     next if (!$difftree{'from_id'});
(or equivalent).

> +
>                       $file = to_utf8($file);
> -                     print "$file<br/>\n";
> +                     print "<li>$file ";
> +                     print "[<a href=\"". esc_html("$my_url?p=$project;a=blobdiff;f=$file;h=$hash;hp=$hashparent;hb=$commit;hpb=$parent") ."\">diff</a>] ";
> +                     print "[<a href=\"". esc_html("$my_url?p=$project;a=blame;f=$file;hb=$commit") ."\">blame</a>] " if gitweb_check_feature('blame');
> +                     print "[<a href=\"". esc_html("$my_url?p=$project;a=history;f=$file;h=$commit") ."\">history</a>] ";
> +                     print "</li>\n";
esc_url, not esc_html here. Or use the href() subroutine with -full=>1
option (after applying the patch I send which added this to href()).

P.S. Please reply also to git mailing list.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

