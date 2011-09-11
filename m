From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] sparse: Fix some "symbol not declared" warnings
Date: Sun, 11 Sep 2011 14:38:10 -0700
Message-ID: <7vobyqn4jh.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2rjN-0004Jk-8Q
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 23:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760412Ab1IKViP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 17:38:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755250Ab1IKViN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 17:38:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7E94320;
	Sun, 11 Sep 2011 17:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Idtyn01Ew2lQmxyhj3/wuEoL2po=; b=DTkWXPX889VUcwk64v/o
	2f2pNt5AzWx3f12Yh2B5RlHdHHV27KekOwVrbvCULqCsGFFaE7AMOHdilIpSmNxQ
	snlLFAOjsQvIaLSd22h/YtsQzjl0pqMI++ghNOzSqvcoqT/7B1R4zG3YlewmUc0P
	YV35RBmwgcC7IHmDqIsoSp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YfCN+ZW0l/+lpMwzAFRk94K2+tMY8fwk4REazXmUQ9O3tO
	V3hny9g4eREn90MXOxHoi5a3z91QDOf21Nkt0Qqxci4/DrxITvnMNFj3FjBZ6y/q
	0dTyYUPokqrmTfIZMmnlK2/b2QFur8zeOQePH8RMVb3X3hupA7WHBRjBXw8UA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97827431F;
	Sun, 11 Sep 2011 17:38:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FE08431E; Sun, 11 Sep 2011
 17:38:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 594FCC26-DCBE-11E0-A1DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181194>

There are many others that can be identified by running the attached
script after you build your git. I'll follow this message up with three
consolidated patches, but the latter two needs to be split into smaller
pieces to be either queued on top (for topics in next) or squashed into
(for topics in pu), which I am not going to do myself today (hint, hint).

#!/usr/bin/perl -w

my %defd = ();
my %used = ();
my %def_ok = map { $_ => 1 } qw(
	main
	alloc_report
	have_git_dir
	prepare_git_cmd
	print_string_list
	tm_to_time_t
	unsorted_string_list_has_string
	xdl_atol
	xdl_cha_first
	xdl_cha_next
	xdl_mmfile_size
	xdl_num_out
	xdl_recs_cmp
);

for (<*.o>, <*/*.o>, <*/*/*.o>) {
	my $obj = $_;
	open(I, "-|", qw(nm -g), $obj) or die;
	while (<I>) {
		unless (/^[0-9a-f ]+([A-Z]) (\S*)$/) {
			print STDERR "? $_";
			next;
		}
		if (($1 eq "U") || $1 eq "C") {
			$used{$2}++;
		}
		else {
			push @{$defd{$obj}}, $2;
		}
	}
	close I;
}

for my $obj (sort keys %defd) {
	my $syms = $defd{$obj};
	for my $sym (@$syms) {
		next if exists $used{$sym} or exists $def_ok{$sym};
		print "$obj	- $sym\n";
	}
}
