From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: [RFC] File system difference handling in git
Date: Tue, 22 Jan 2008 09:21:02 +0000
Message-ID: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 10:21:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHFK8-0004oV-FM
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 10:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140AbYAVJVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 04:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774AbYAVJVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 04:21:09 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:4535 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbYAVJVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 04:21:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2071369rvb.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 01:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=B/WqsOXhHpGq+la8XATvYMgFEVKab3QDOiFRHZ1UHRw=;
        b=i8uzRLBLEL93Fa/YikJSL/7aOkiApIR4nTno5BW5XyzYD3Qer+Q5mpDYl2yB6pzFCqujw8CpFAet3ayJwkCfIwDtaRuuTQS53lHydYim3sPHU3yHTLvOsG3yAEHxRvnibvnuzVfZ8D/Cdg0iQbWAw/NDq2WWTcHRn90n6HuuMDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kOv38ykYOpPGD1CbClibds/NUZSfnv0cYUS04KmHYSRJocYYV7LD6fXMed/nV9l7rAcfK1rGcNOWUCjhFR3/nw3bs/kkqZU6lOT9IJITgToAOoGE/o4QgEbiqa9XxCLnFADDxvFtH+7c7sLxLJMgNmVHCxnu3jehsAT4PCPTUaA=
Received: by 10.141.163.12 with SMTP id q12mr5198793rvo.265.1200993662335;
        Tue, 22 Jan 2008 01:21:02 -0800 (PST)
Received: by 10.141.123.8 with HTTP; Tue, 22 Jan 2008 01:21:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71437>

Hi,

Observing the various comments w.r.t. the different (potentially
braindead) filesystems that are available, there are two general
categories for behavioural differences:

  1.  File name representation

For Linux file systems (correct me if I am wrong here), they all store
the file name as-is. The question here is what happens on
Windows-based file systems (e.g. NTFS) that are being read on Linux?

For Mac filesystems, you have the Unicode character decomposition
issues to deal with.

For Windows, you have UTF-16 filename support.

There are two basic usages for file/directory names: passing the name
to the Operating System; getting the name from the Operating System.
Therefore, you have:

   os_to_git_path( const NATIVECHAR * ospath, strbuf * gitpath );
   git_to_os_path( const char * gitpath, const NATIVECHAR * ospath, int oslen );

These can then be used to handle Operating System differences (e.g.
use WideCharToMultiByte/MultiByteToWideChar conversion on Windows to
map between UTF-8 and UCS-2/UTF-16).

If Mac has an API to handle its strange behaviour, that can be used
here as well.

  2.  Case (in)sensitivity

Here, you have the following cases:

  1.  git and the filesystem say that the files are different.

Update the git directory tree and move the file on the filesystem.

  2.  git and the filesystem say that the files are the same.

Generate an error as is currently done in git.

  3.  git says that the files are different, but the filesystem says
that the files are the same.

Allow the move, updating the git directory tree only.

- Reece
