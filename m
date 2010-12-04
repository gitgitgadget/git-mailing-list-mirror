From: Junio C Hamano <gitster@pobox.com>
Subject: Intermittent failures in t9119
Date: Fri, 03 Dec 2010 18:19:16 -0800
Message-ID: <7vmxoml1p7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sat Dec 04 03:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POhmJ-0001Zb-GE
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 03:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896Ab0LDCT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 21:19:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56541 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab0LDCT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 21:19:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5366A3997;
	Fri,  3 Dec 2010 21:19:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=3Xuf
	iUjFpmaQ/RExT0mbs85TFrc=; b=Vnas5ml33EyHwsp3r/KBOAE0xYz1hyxezUfu
	0KttMflxWenOVcd2S5cTQ6dr2i6mdUr2OtKbQWiyMSsNNicBFxwiqbnawJem544e
	RkXxRh5qYzNPY1vPEercvrCbEuXFQfriQYkkM7ZlqHYMzM0aqghFJB5zbiATm96h
	Ztmrzpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	kouoc0YDR5Lfx7sSCqEVNpZ22WvvlbRKLERA//TgyZ11QvUArkaAZiit0p8dAClg
	PZ9bvsfY+8n8MT7JSTpPvgyDpSBNJnZ9k7IG+bKT69Zwe5Od43zACu3eG6IqthPh
	eX9HBOqyTj9Xs1nSj46InPgtkOuCXmlN282+FdelPQg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 192653996;
	Fri,  3 Dec 2010 21:19:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2CD723995; Fri,  3 Dec 2010
 21:19:40 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F53104AC-FF4C-11DF-8FB8-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162880>

Sorry for bringing up an old story, but since you added "git svn info"
with e6fefa9 (git-svn info: implement info command, 2007-11-21),...

I am seeing breakages from the said test:

    not ok - 6 info file
    #
    #               (cd svnwc; svn info file) > expected.info-file &&
    #               (cd gitwc; git svn info file) > actual.info-file &&
    #               test_cmp expected.info-file actual.info-file

    : trash directory.t9119-git-svn-info/master; diff *.info-file
    12c12
    < Text Last Updated: 2010-12-04 00:34:58 +0000 (Sat, 04 Dec 2010)
    ---
    > Text Last Updated: 2010-12-04 00:34:57 +0000 (Sat, 04 Dec 2010)

I do not know if we should expect output from "svn info" to match exactly
like the above.  Is "Text Last Updated" supposed to show the stat
timestamp of the working tree (I see "(stat $path)[9]" there)?  If so,
unless the checkout/update in svnwc and gitwc prior to this test was done
within the same second, we do not have a good reason to expect that these
files should be identical.

I _think_ "svn info file" actually gives the timestamp of the revision
that touched the file the last (in their linear worldview of the history),
so perhaps this is demonstrating the real bug, but only when the test runs
very slowly?
