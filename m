From: Alexandre Garnier <zigarn@gmail.com>
Subject: [BUG] Git does not convert CRLF=>LF on files with \r not before \n
Date: Tue, 21 Apr 2015 15:51:34 +0200
Message-ID: <CAFFOgCUTxnbL7vJpf1Hw39CJL_p2raDZ2a3DehhYhdbkVyi2fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 15:51:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkYaW-0008Ef-7L
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 15:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbbDUNvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 09:51:39 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:36217 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbbDUNvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 09:51:36 -0400
Received: by lagv1 with SMTP id v1so151669400lag.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=GsvSBtc+eUq8sq/b7sarJZVJ6zr6PTPvl01gO3RBEf8=;
        b=pOLYlrKI+eur4yDc+DEgcHv9WVJ8Evp/Kfpmwuoeud4TrBN69ixEgQLw7XBH9RqmjK
         1dPbJqB2RNsiMDycKjU6J/oNIJJRz8eGw5nrA7IM4EmMtBQeosCIYQNxx/AlxOlaP635
         0dXLKfkd2fNkA4efLHc3mOdVmiX/NYM15s2hADgDvHGEKPiuoJjsTHvw5O7Npno9AKik
         xWYZcR8TV3BJwEzk5k4vyQRbM/kMH4Ry1nsmuFwmH1GbuUkLWaqq6yojyNDMArLWQkAk
         U5Y/JrPrq3tJDgy2SGHvDsIAZ6+ZPq58/LeEl5ZVKSDNu8eR4/UDw3yHoBXiEFyLsGuY
         YNxg==
X-Received: by 10.112.16.227 with SMTP id j3mr20151339lbd.43.1429624294932;
 Tue, 21 Apr 2015 06:51:34 -0700 (PDT)
Received: by 10.25.156.67 with HTTP; Tue, 21 Apr 2015 06:51:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267529>

Here is a test:

git init -q crlf-test
cd crlf-test
echo '*       text=auto' > .gitattributes
git add .gitattributes
git commit -q -m "Normalize EOL"
echo -ne 'some content\r\nother \rcontent with CR\r\ncontent\r\nagain
content with\r\r\n' > inline-cr.txt
echo "Working directory content:"
cat -A inline-cr.txt
echo
git add inline-cr.txt
echo "Indexed content:"
git show :inline-cr.txt | cat -A

Result
------
File content:
some content^M$
other ^Mcontent with CR^M$
content^M$
again content with^M^M$

Indexed content:
some content^M$
other ^Mcontent with CR^M$
content^M$
again content with^M^M$

Expected result
---------------
File content:
some content^M$
other ^Mcontent with CR^M$
content^M$
again content with^M^M$

Indexed content:
some content$
other ^Mcontent with CR$
content$
again content with^M$
# or even 'again content with$' for this last line

If you remove the \r that are not at the end of the lines, EOL are
converted as expected:
File content:
some content^M$
other content with CR^M$
content^M$
again content with^M$

Indexed content:
some content$
other content with CR$
content$
again content with$

-- 
Alex
