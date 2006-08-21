From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] gitweb: href() function to generate URLs for CGI
Date: Mon, 21 Aug 2006 17:39:32 +0200
Message-ID: <200608211739.32993.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 21 17:46:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFBs2-0007Sz-Sm
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 17:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWHUPjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 11:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbWHUPjU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 11:39:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:33346 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751884AbWHUPjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 11:39:19 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1914722nfa
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 08:39:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VrDQmijzxKvkFEjCVFN0N3cOYX7foOekMOb4bph+R3j5OUxnEBVFL5UpzmWS3p3gq2kkohHyLaAVdGzGagFV55l2nq7NyC+5g0kNt0pJ3qgnn5ukTU70ael+d2agr/QcNhuHzr8yX+dSjul92Hc66HXRxlaipylr7gjiqpDLr3g=
Received: by 10.49.29.2 with SMTP id g2mr7858835nfj;
        Mon, 21 Aug 2006 08:39:17 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id m16sm682108nfc.2006.08.21.08.39.17;
        Mon, 21 Aug 2006 08:39:17 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25798>

In first version of href() function we had
(commit 06a9d86b49b826562e2b12b5c7e831e20b8f7dce)

	my $href = "$my_uri?";
	$href .= esc_param( join(";",
		map {
			"$mapping{$_}=$params{$_}"
		} keys %params
	) );

First, there was a question what happend if someone would enter 
parameter name incorrectly, and some key of %params is not found in 
%mapping hash. The above code would generate warnings (which web admins 
frown upon), and empty (because undef) parameters corresponding to e.g. 
mistyped parameter name. 

One solution (sweeping under the carpet) would be to use parameter key 
as CGI parameter name if it is not found in the %mapping, i.e.

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

(we cannot put condition in map BLOCK, because map does not filter, only 
act on elements, so the result would be empty parameter (e.g. ";;" in 
generated URL), I guess without warnings).

Which solutions should be chosen? If the one is chosen, I can send the
patch.


Second problem is that using href() function, although it consolidates 
to generate URL for CGI, it changes the order of CGI parameters. It 
used to be that 'p' (project) parameter was first, then 'a' (action) 
parameter, then hashes ('h', 'hp', 'hb'), last 'f' (filename) or 
'p' (page) or 's' (searchtext). The simplest and fastest solution would 
be to create array with all keys of %mapping in appropriate order and 
do something like this:

	my @mapping_sorted = ('project', 'action', 'hash',
		'hash_parent', 'hash_base', 'file_name', 'searchtext');

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
