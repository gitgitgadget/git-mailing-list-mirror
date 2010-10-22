From: Fede <fedux@lugmen.org.ar>
Subject: Re: [PATCH] Fix git-apply with -p greater than 1
Date: Fri, 22 Oct 2010 10:42:55 -0300
Message-ID: <4CC194DF.9040803@lugmen.org.ar>
References: <1287699122-26702-1-git-send-email-fedux@lugmen.org.ar> <7viq0urfbz.fsf@alter.siamese.dyndns.org> <20101022053140.GB786@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 15:43:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Htj-0001xe-AD
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 15:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab0JVNnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 09:43:01 -0400
Received: from 64-76-18-116.static.impsat.net.ar ([64.76.18.116]:49515 "EHLO
	mother.lugmen.org.ar" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab0JVNnA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 09:43:00 -0400
Received: from mail.fedux.com.ar (unknown [186.18.64.224])
	by mother.lugmen.org.ar (Postfix) with ESMTPSA id D5E5C19E699;
	Fri, 22 Oct 2010 10:42:58 -0300 (ART)
Received: from [192.168.8.5] (unknown [192.168.8.5])
	by mail.fedux.com.ar (Postfix) with ESMTPS id 6D18410053;
	Fri, 22 Oct 2010 10:42:57 -0300 (ART)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.11) Gecko/20101020 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <20101022053140.GB786@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159687>

Jonathan Nieder wrote:
> Junio C Hamano wrote:
>> +test_expect_success 'apply (-p2) diff, mode change only' '
>> +	cat >patch.chmod <<-\EOF &&
>> +	diff --git a/sub/file1 b/sub/file1
>> +	old mode 100644
>> +	new mode 100755
>> +	EOF
>> +	chmod 644 file1 &&
>> +	git apply -p2 patch.chmod &&
>> +	test -x file1
> I had thought -p was only supposed to apply to traditional patches.
> Maybe a documentation update would avoid confusion?
>
> 	-p<n>
> 	   Remove <n> leading slashes from traditional diff paths.
> 	   The default is 1.

Currently, if the patch is mode-change only then the filename is taken
from the line "diff --git ...". There is a function git_header_name()
that extracts that name. This function could be a lot simpler and I'm
working on that, but meanwhile I'd like to provide a quick fix.

Right now, if at least one of the filenames is double quoted then -p
greater than 1 works correctly. The only failing case is when both names
are unquoted and my patch fixes that.

This work with -p2:

diff --git "a/sub/file1" b/sub/file1
old mode 100644
new mode 100755

diff --git a/sub/file1 "b/sub/file1"
old mode 100644
new mode 100755

diff --git "a/sub/file1" "b/sub/file1"
old mode 100644
new mode 100755

This one doesn't:

diff --git a/sub/file1 b/sub/file1
old mode 100644
new mode 100755

My patch fixes the later case.

There is a similar issue with renames and I'm working on that.
Meanwhile, I'd like to know what do you think of that.

PS: Hamano's test  'apply (-p2) diff, mode change only' fails without my
patch and passes with it. I'll provide a new patch including the test.
