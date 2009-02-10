From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Tue, 10 Feb 2009 15:56:49 -0800
Message-ID: <7vd4dpkfr2.fsf@gitster.siamese.dyndns.org>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
 <200902101758.00062.robin.rosenberg@dewire.com>
 <7vd4dqm4io.fsf@gitster.siamese.dyndns.org>
 <200902110051.20975.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 00:58:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2Uk-0007LE-Mx
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbZBJX47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbZBJX47
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:56:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbZBJX47 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:56:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DAA8C98ACE;
	Tue, 10 Feb 2009 18:56:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D8E7198ACB; Tue,
 10 Feb 2009 18:56:51 -0500 (EST)
In-Reply-To: <200902110051.20975.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Wed, 11 Feb 2009 00:51:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 804AD5B4-F7CE-11DD-A104-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109354>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> tisdag 10 februari 2009 21:16:31 skrev Junio C Hamano:
>> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>> 
>> >> I was not talking about any loss.  The result would be a funny mixture of
>> >> permutations of {old-,}pack-*.{pack,idx} the user needs to match up after
>> >
>> > We don't leave old-files around unless we go very very wrong and only in
>> > that case would be leave "old"-files for one pack around and only if gc wants
>> > to replace a pack with the same name. That would not be fatal and the
>> > user can continue repacking to get rid of the redundant stuff once the cause
>> > of them problem is fixed. 
>> 
>> You can succeed for the first name and then fail for the second name, for
>> example, and can end up with old-pack-* and pack-* with the same name.  I
>> found that potentially confusing.  Since you are trying to improve the
>> area, it would be nicer to make it less prone to fail and easier to
>> recover.
>> 
>> Here is another attempt to rewrite it, which is closer to what you are
>> doing in your patch, but hopefully easier to understand what is going on
>> and more atomic.
>
> Almost perfect.
>
>> +# If renaming failed for any of them, roll the ones we have
>> +# already renamed back to their original names.
>> +if test -n "$failed"
>> +then
>> +	rollback_failure=
>> +	for file in $rollback
>> +	do
>> +		mv "$PACKDIR/old-$file" "$PACKDIR/$file" ||
>> +		rollback_failure="$rollback_failure $file"
>> +	done
>> +	if test -n "$rollback_failure"
>> +	then
>> +		echo >&2 "WARNING: Some packs in use have been renamed by"
>> +		echo >&2 "WARNING: prefixing old- to their name, in order to"
>> +		echo >&2 "WARNING: replace them with the new version of the"
>> +		echo >&2 "WARNING: file.  But the operation failed, and"
>> +		echo >&2 "WARNING: attempt to rename them back to their"
>> +		echo >&2 "WARNING: original names also failed."
>> +		echo >&2 "WARNING: Please rename them in $PACKDIR manually:"
>> +		for file in $rollback_failure
>> +		do
>> +			echo >&2 "WARNING:   old-$file -> $file"
>> +		done
>
> Exit 1 here.  We did not succeed in rolling back
>
>> +	fi
>> +	exit 1
>
> But here we should exit 0 because we succeeded in rolling back the changes,
> so we do not need to scare the user.

We failed to honor what the end user wanted: to repack.  Why should we
exit 0 here?
