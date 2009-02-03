From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [JGIT PATCH] Fix AbstractTreeIterator path comparion betwen 'a'
 and 'a/b'
Date: Tue, 03 Feb 2009 18:10:30 +0100
Message-ID: <49887A86.2040602@gmail.com>
References: <1233605617-14513-1-git-send-email-torarnv@gmail.com> <20090203161539.GV26880@spearce.org> <49887274.8040601@gmail.com> <20090203170337.GX26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUOok-000677-S9
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbZBCRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752494AbZBCRKp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:10:45 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:57238 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbZBCRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:10:45 -0500
Received: by ewy14 with SMTP id 14so2605514ewy.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=XVaF5j58sX+sWqFMzXP5ksA1yAFupqLdkjrgbwwaijE=;
        b=U4CXyzj4U7+IMLYhh2vSfxFGLxvWAh6LDuyQtjxM0Dp6TyZyq2SISx1AYMiEFCL/5I
         jmFh6K/lvlhI5YVYhMSTyBfb6xPtKCWSUnaQDexGVMtBFBrjs+vlGa8vfPVaCG1Xogfa
         SiE9I+za9TswDlRH7Gtpsm3xqOVDGAqjad4Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Wg3ZWd0DgElJDdGBSj6DRDxl5heJFFnqqNjV4nag6mSSKdPQ2pZTTX/7Z0l2hIBm6G
         0lHKm0Jk3K9UF4afEdujc7B6PPs0DqAgnBAsrzccvllKfWZ17/a5nIoBmAvF+L3YSU01
         GvnFRwdoTe2uF1kqdeTablkCpxSjbgWrYm4qk=
Received: by 10.103.225.11 with SMTP id c11mr2543692mur.24.1233681041228;
        Tue, 03 Feb 2009 09:10:41 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id w5sm390841mue.3.2009.02.03.09.10.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 09:10:37 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090203170337.GX26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108218>

Shawn O. Pearce wrote:
> OK, so I think this is a valid test case, and as it turns out,
> it passes with the library unmodified:
> 
> --8<--
> +	public void testPathCompare() throws Exception {
> +		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
> +				new FakeTreeIterator("a", FileMode.TREE)) == 0);
> +
> +		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathCompare(
> +				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) == 0);
> +
> +		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathCompare(
> +				new FakeTreeIterator("a", FileMode.TREE)) < 0);
> +
> +		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
> +				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) > 0);
> +	}
> ----

Okey, I'll post a new patch with just those test cases, no changes to
the pathCompare, so we at least have those tests.

> Which means whatever problem you have been seeing in the decorator
> code is different than what we were originally thinking.  Perhaps you
> are trying to use the tree iterator APIs in a way that they aren't
> meant to be used (like passing in full paths where only a path name
> component is expected?), or there is something else lurking that
> we don't understand.


Ahh, I see. My patch was based on the assumption that 'a/b' was a valid
comparison, since I was seeing similar comparisons in live code. But as
you say, that's probably due to how I use the iterators. I will go back
and investigate how I ended up with 'a/b' paths in the first place.

Thanks :)

Tor Arne
