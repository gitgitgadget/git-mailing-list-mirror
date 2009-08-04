From: Junio C Hamano <gitster@pobox.com>
Subject: Re: conflict status
Date: Tue, 04 Aug 2009 00:56:35 -0700
Message-ID: <7vhbwoypu4.fsf@alter.siamese.dyndns.org>
References: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net>
 <fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com>
 <200908032017.35101.trast@student.ethz.ch>
 <7vvdl4925k.fsf@alter.siamese.dyndns.org>
 <4F52523A-2CEA-4CD3-A094-A2627E2A4403@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Michael Wild <themiwi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:57:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEtJ-0006fT-8g
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbZHDH4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 03:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbZHDH4w
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:56:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbZHDH4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 03:56:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EB191C270;
	Tue,  4 Aug 2009 03:56:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 46BEF1C25F; Tue,  4 Aug 2009
 03:56:37 -0400 (EDT)
In-Reply-To: <4F52523A-2CEA-4CD3-A094-A2627E2A4403@users.sourceforge.net>
 (Michael Wild's message of "Tue\, 4 Aug 2009 09\:10\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E560F1E-80CC-11DE-9224-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124769>

Michael Wild <themiwi@users.sourceforge.net> writes:

> # get all conflicts
> conflicts="$(git-status | awk '/unmerged:/{print $3;next}')"
>
> for f in $conflicts; do
>   # extract the file mode for base, local and remote
>   base_mode=$(git ls-files -u -- "$f" | awk '{if ($3==1) print $1;}')
>   local_mode=$(git ls-files -u -- "$f" | awk '{if ($3==2) print $1;}')
>   remote_mode=$(git ls-files -u -- "$f" | awk '{if ($3==3) print $1;}')
>   # create the status flags
>   describe_state "$local_mode"
>   describe_state "$remote_mode"
>   # append the file name
>   echo " $f"
> done

Looks an awfully inefficient way to say "git ls-files -u" to me.  If you
do not see stage 2, you do not have it.  If you do not see stage 3, they
do not have it.

If you really really want to condense the object name information out, you
could do something like this.

-- >8 --
#!/bin/sh
git ls-files -u -z |
perl -e '
	$/ = "\0";
        my ($last_path, @stage);
        sub describe_mode {
        	my $ours = $_[0];
		my $sign;
                if (!defined $ours) {
                	$sign = "d";
		} elsif (defined $stage[1]) {
                	$sign = "m";
		} else {
			$sign = "c";
                }
		return $sign;
        }
	sub flush_path {
        	printf("%s %s %s\n",
                	describe_mode($stage[2]),
                	describe_mode($stage[3]),
			$last_path);
		$last_path = undef;
        	@stage = ();
        }
        while (<>) {
		chomp;
        	my ($mode, $sha1, $stage, $path) =
                	/^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$/;
		if (defined $last_path) {
			flush_path() if ($path ne $last_path);
                }
                $stage[$stage] = 1;
                $last_path = $path;
	}
        if (defined $last_path) {
                flush_path() if ($path ne $last_path);
        }
'
-- 8< --

I however do not think it is all that interesting, though.
