From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Consolidate escaping/validation of query string
Date: Sun, 24 Sep 2006 14:31:08 +0200
Organization: At home
Message-ID: <ef5tqa$bjd$1@sea.gmane.org>
References: <ef4csl$7vk$1@sea.gmane.org> <20060924113932.11208.33780.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 24 14:31:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRT98-0008KW-8k
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 14:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWIXMbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 08:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWIXMbe
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 08:31:34 -0400
Received: from main.gmane.org ([80.91.229.2]:706 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750953AbWIXMbd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 08:31:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRT8q-0008Gc-1r
	for git@vger.kernel.org; Sun, 24 Sep 2006 14:31:28 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 14:31:28 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 14:31:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27666>

Petr Baudis wrote:

> Consider:
> 
>       http://repo.or.cz/?p=glibc-cvs.git;a=tree;h=2609cb0411389325f4ee2854cc7159756eb0671e;hb=2609cb0411389325f4ee2854cc7159756eb0671e
> 
> (click on the funny =__ify file)
> 
> We ought to handle anything in filenames and I actually see no reason why
> we don't, modulo very little missing escaping that this patch hopefully
> also fixes.
> 
> I have also made esc_param() escape [?=&;]. Not escaping [&;] was downright
> buggy and [?=] just feels better escaped. ;-) YMMV.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>

This patch contains a few unrelated changes:
 * changing semantics of esc_param subroutine
 * adding some esc_html where it could be needed
 * removing $file_name and $file_parent validation

About change to esc_param: we need current version of esc_param, perhaps
to be named esc_url to be able to say esc_url($home_link) and soon
esc_url($githelp_url).

About adding esc_html where it could be needed: good change, see
my comments below.

About removing $file_name and $file_parent validation: those parameters
have exactly the same textual restrictions as $project parameter - they
are pathnames.

> @@ -2439,7 +2429,7 @@ sub git_blame2 {
>       if ($ftype !~ "blob") {
>               die_error("400 Bad Request", "Object is not a blob");
>       }
> -     open ($fd, "-|", git_cmd(), "blame", '-l', $file_name, $hash_base)
> +     open ($fd, "-|", git_cmd(), "blame", '-l', '--', $file_name, $hash_base)
>               or die_error(undef, "Open git-blame failed");
>       git_header_html();
>       my $formats_nav =

Slightly unrelated change. Shouldn't it be

        open $fd, "-|", git_cmd(), "blame", '-l', $hash_base, "--", $file_name

by the way?

> @@ -3135,7 +3125,7 @@ sub git_blobdiff {
>                       -type => 'text/plain',
>                       -charset => 'utf-8',
>                       -expires => $expires,
> -                     -content_disposition => qq(inline; filename="${file_name}.patch"));
> +                     -content_disposition => qq(inline; filename=") . quotemeta($file_name) . qq(.patch"));
>  
>               print "X-Git-Url: " . $cgi->self_url() . "\n\n";
>  

I'd check other places where we output Content-Disposition: header.
At least one place needs similar quotemeta somewhere.

> @@ -3585,7 +3575,7 @@ XML
>                       if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
>                               next;
>                       }
> -                     my $file = validate_input(unquote($7));
> +                     my $file = esc_html(unquote($7));
>                       $file = decode("utf8", $file, Encode::FB_DEFAULT);
>                       print "$file<br/>\n";
>               }

I'd say perhaps

        my $file = unquote($7);
        $file = decode("utf8", $file, Encode::FB_DEFAULT);
        print esc_html($file) . "<br/>\n";

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
