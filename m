From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] gitweb: href() function to generate URLs for CGI
Date: Mon, 21 Aug 2006 17:21:39 +0200
Organization: At home
Message-ID: <eccj1n$sio$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 21 17:40:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFBqJ-0006yR-DP
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 17:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWHUPha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 11:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWHUPha
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 11:37:30 -0400
Received: from main.gmane.org ([80.91.229.2]:20199 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751883AbWHUPha (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 11:37:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFBkL-0005RX-Te
	for git@vger.kernel.org; Mon, 21 Aug 2006 17:31:28 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 17:31:25 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 17:31:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25797>

In first version of href() function we had
(commit 06a9d86b49b826562e2b12b5c7e831e20b8f7dce)

        my $href = "$my_uri?";
        $href .= esc_param( join(";",
                map {
                        "$mapping{$_}=$params{$_}"
                } keys %params
        ) );

First, there was a question what happend if someone would enter parameter
name incorrectly, and some key of %params is not found in %mapping hash.
The above code would generate warnings (which web admins frown upon), and
empty (because undef) parameters corresponding to e.g. mistyped parameter
name. 

One solution (sweeping under the carpet) would be to use parameter key as
CGI parameter name if it is not found in the %mapping, i.e.

        my $href = "$my_uri?";
        $href .= esc_param( join(";",
                map {
                        if (exists $mapping{$_}) {
                                "$mapping{$_}=$params{$_}"
                        } else {
                                "$_=$params{$_}"
                        }
                } keys %params
        ) );

Another solution would be to skip parameters which are not found in
%mapping. Correct way to do this is:

        my $href = "$my_uri?";
        $href .= esc_param( join(";",
                map {
                        "$mapping{$_}=$params{$_}"
                } grep { exists $mapping{$_} } keys %params
        ) );

(we cannot put condition in map BLOCK, because map does not filter, only act
on elements, so the result would be empty parameter (e.g. ";;" in generated
URL), I guess without warnings).

Which solutions should be chosen? If the one is chosen, I can send the
patch.


Second problem is that using href() function, although it consolidates to
generate URL for CGI, it changes the order of CGI parameters. It used to be
that 'p' (project) parameter was first, then 'a' (action) parameter, then
hashes ('h', 'hp', 'hb'), last 'f' (filename) or 'p' (page) or
's' (searchtext). The simplest and fastest solution would be to create
array with all keys of %mapping in appropriate order and do something like
this:

        my @mapping_sorted = ('project', 'action', 'hash', 'hash_parent',
                'hash_base', 'file_name', 'searchtext');

        my $href = "$my_uri?";
        $href .= esc_param( join(";",
                map {
                        "$mapping{$_}=$params{$_}"
                } grep { exists $params{$_}} @mapping_sorted;
        ) );

The problem is of course updating both %mappings and @mapping_sorted.

Is this really a problem, should this (ordering of CGI parameters)
addressed?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
