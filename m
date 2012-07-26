From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] test-lib: filesystem prerequisites
Date: Thu, 26 Jul 2012 11:16:45 -0700
Message-ID: <7vtxwu75gy.fsf@alter.siamese.dyndns.org>
References: <5001B82B.1060201@web.de>
 <cover.1343309173.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:17:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuScU-00014v-KF
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 20:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab2GZSQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 14:16:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab2GZSQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 14:16:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B19A834D;
	Thu, 26 Jul 2012 14:16:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ap0vRXT5lAQKsM776zUBlMXF9uY=; b=mCjYM0
	00DQ8a1qCPUFRbJcCmxy9pKIHkX6eqqZko+55skZ2iglAG8JJu18dAfKVn4hzXpz
	L0/uLg+K6MmyM6+veYMQmhMDmKigNGOZV3fDqCcJEvqSCWHSj7rW6sHwSVatVEYC
	bJDVir9T6Iuq2DxsFccF1W+rqjsCMPZKfrCDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RA4ZdswLAnEM4+hme+hDI3CDLxEhh3JA
	jvMZydqIsmglQtKUi4DdjKBXgQP8AZOwrfq+bAuSqJbDM7j2qTLneh0+TGlyV4f2
	M5bfbZRnhYI1vybPrMHTIssHWcOZGWHw1BTC1NgIis0Gr/hqpnuGenWxL6GeKgFl
	cHC9xfIvZqs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 785B9834C;
	Thu, 26 Jul 2012 14:16:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D272C834B; Thu, 26 Jul 2012
 14:16:46 -0400 (EDT)
In-Reply-To: <cover.1343309173.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Thu, 26 Jul 2012 15:39:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FB3EBA2-D74E-11E1-9BE4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202289>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This mini series provides and makes use of test prerequisites for
> case insensitivity, symlinks and unicode conversion.
>
> SYMLINKS existed before but was not used in t0050.
> CASE_INSENSITIVE_FS was defined in t0003 rather than test-lib (and redone in
> t0050).
> UTF8_NFD_TO_NFC did not exist but was redone in two ways in two tests.
>
> After this series, all 3 are defined in test-lib and used in the various tests.

Consolidating the logic to set necessary prerequisites used in
various scripts is very good, but I am not sure adding them to
test-lib and run them unconditionally is a good idea.  SYMLINKS is
used by 47 among 595 tests, which is common enough, but the new ones
are not common enough.  I do not think we want to create a temporary
"junk" dir, two temporary "camelcase" files, read and compare them,
when nobody in the script cares.

We do not have to split them into separate include files, though, in
order to avoid such waste.  Instead, you can make the logic to set
prerequisite conditional inside test-lib.sh and update the users.

Something like:

	(in t/test-lib.sh)
	case ",$TEST_WANT_PREREQ," in
	*,CASE_INSENSITIVE_FS,*)
		mkdir junk &&
                echo good >junk/CamelCase &&
                echo bad >junk/camelcase &&
                test "$(cat junk/CamelCase)" == good ||
                test_set_prereq CASE_INSENSITIVE_FS
		rm -fr junk
	esac

	(at the beginning of t/t0003-attributes.sh)
	#!/bin/sh
        test_description=gitattributes
        TEST_WANT_PREREQ=CASE_INSENSITIVE_FS,SYMLINKS
	. ./test-lib.sh

Thanks.
