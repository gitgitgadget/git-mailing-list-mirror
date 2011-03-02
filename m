From: Robert Wruck <wruck@tweerlei.de>
Subject: [BUG] Out of memory in Git.pm
Date: Wed, 02 Mar 2011 14:01:43 +0100
Message-ID: <4D6E3FB7.60600@tweerlei.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 14:08:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pulms-0004cb-Rt
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 14:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327Ab1CBNIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 08:08:13 -0500
Received: from mail.tweerlei.de ([88.198.48.46]:39806 "EHLO mail.tweerlei.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860Ab1CBNIM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 08:08:12 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Mar 2011 08:08:12 EST
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.tweerlei.de (Postfix) with ESMTPSA id 3B4DA277C1
	for <git@vger.kernel.org>; Wed,  2 Mar 2011 14:01:57 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168307>

Hi,

there seems to be a problem in Git.pm (git-1.7.4.1, sub cat_blob, line 
891) where the whole object is read into memory ($blob) before writing 
to $fh:

	my $blob;
	my $bytesRead = 0;

	while (1) {
		my $bytesLeft = $size - $bytesRead;
		last unless $bytesLeft;

		my $bytesToRead = $bytesLeft < 1024 ? $bytesLeft : 1024;
		my $read = read($in, $blob, $bytesToRead, $bytesRead);
		unless (defined($read)) {
			$self->_close_cat_blob();
			throw Error::Simple("in pipe went bad");
		}

		$bytesRead += $read;
	}

Maybe it would be better to write each chunk directly to $fh ?
If so, I could create a patch.

-Robert
