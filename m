From: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
Subject: git-svn show-externals and svn version
Date: Sun, 19 Feb 2012 19:53:56 +0100
Message-ID: <E59CCE45-6F92-4748-9B6E-2A562647904B@nikolaus-demmel.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 19:54:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzBtd-0007aA-8B
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 19:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710Ab2BSSx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 13:53:59 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:53324 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab2BSSx6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 13:53:58 -0500
Received: from [192.168.178.100] (c-cca272d5.015-455-73746f34.cust.bredbandsbolaget.se [213.114.162.204])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0M8K0I-1SLpO30mnq-00w90Z; Sun, 19 Feb 2012 19:53:57 +0100
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:vSWo0RTuseXj6u0dOMuMEv0tH+W0tvbMEf0czLwzDWl
 SpQDFCdeNbRmRHyljTmBBh+JFhxUTZlGgjRF2ATGFZzt2cd2t3
 J6SSDE8vDLwDpb7gu5Wrc+AguLplEDmmDBCOUvJexzNPcoXJ8e
 4yDu1wGbBMgDw64SsEQJTHel7IkGCCt4UHdSgvUPaumkHOhPnn
 X3jjixTUbzPfhVnTPuALpPuutJSP6V/YQzCjuLb+8dSRNqb3wS
 njoKM4KC/fc7YpVcdcyPG+tTQLbcvbkdpJ7Ss4WPGzV0bdkwA2
 +gtG2+Ulp8g4bgdz5WIIm0Z3eGVvwPqoFox+1iLQWUk9dIzZKH
 i4/4wbuSebrbu4J8Yufs5U+uL6DH823INA6vUVeBDYWXwxckvA
 t95PEnIpT44DMKqSFXj+LM+AAjoYqjFttE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191028>

Hi,

I am currently investigating getting support for svn externals in git-svn (you might have noticed my other mails).

It turns out that there are quite a few scripts floating around that use the output of show-externals and then try to pull these externals with git-svn into independent repositories and add the folders as submodules to the root repository.

However, none of them work for me, and the primary reason AFAICT is that they were written for the pre svn1.5 format of svn:externals. From 1.5 svn supports a new format of svn:externals, which changes the order of revision, repository-url, and local folder, and also adds the posibility to add relative urls, peg-revisions, etc [1].

On top that it seems to me that the output of show-externals was purely designed for the old format. For example, if you compare the output of "git svn show-externals" with "git svn propget svn:externals" in an example repository using the new format [2], you find that the in the show-externals output the prepended "/" and "/instantiations/" at the beginning of each line does not make sense. If the target url (all relative with the ^ syntax in this case) and the sub-folder were swapped in order, as of pre 1.5 svn, it would make much more sense. Also apparently the code for show-externals was added in 2007 and not changed since, whereas svn 1.5 was released in 2008.

What I am not completely clear about is, whether svn 1.5 and later enforces the new syntax, or whether it just adds the new syntax and still has to support the old syntax (which could be distinguished, I guess, by checking of the last part on an entry is an absolute URL instead of a subfolder). Also, I'm not sure if the format depends on the version of the svn-server or the client. I would assume you can check out a repository hosted with svn 1.4 with a 1.5 client. Does the client process the svn:externals and present it in the new format, or is this the text string just taken from the server unaltered (I have not much knowledge of how svn actually works internally)?

Another question is whether the perl svn bindings present the svn:externals in some parsed, standard format, or do they just give you the raw text string?

In order to make show-externals more useful with the svn 1.5 and later syntax, one would maybe need to check the underlying svn version. I guess it is also quite important to retain backwards compatibility, such that users of externals with the old syntax would still get the same output as before.

I would suggest that the show-externals output should be as close as possible to the svn:externals syntax, possibly adapting the subfolder path for nested folders. However here the recursive display of externals for subfolders becomes a bit more tricky, since the URL can also be relative to the subfolder as of the new syntax. Maybe the easiest way to deal with the new syntax in show-externals would be to have each line like it is in the svn-properties, but add a space separated relative path to the corresponding subfolder at the beginning. A tool that uses this is then responsible for making sure the relative URLs are resolved correctly.

To sum up, given that all the questions I have are answered like I think is most likely, it would boil down to changing the output of show-externals for svn 1.5  and later just slightly, namely by inserting an additional space between the prepended subfolder and the actual svn:externals definition in each line.

Any thoughts and/or answers?

Cheers,
Nikolaus


[1] http://svnbook.red-bean.com/en/1.7/svn.advanced.externals.html
[2] http://paste.lisp.org/display/127858