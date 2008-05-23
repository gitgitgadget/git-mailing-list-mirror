From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH v2 07/24] Added findWorkTree method to Repository
 class.
Date: Fri, 23 May 2008 20:12:31 +0200
Message-ID: <4837090F.4000307@web.de>
References: <1210623222-24908-1-git-send-email-florianskarten@web.de> <1210623222-24908-8-git-send-email-florianskarten@web.de> <20080513002409.GC29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 23 20:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzblc-0002Ep-Tp
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 20:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbYEWSMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 14:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103AbYEWSMd
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 14:12:33 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:49905 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYEWSMb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 14:12:31 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 831DBDE14CDA;
	Fri, 23 May 2008 20:12:30 +0200 (CEST)
Received: from [84.150.81.80] (helo=[192.168.1.50])
	by smtp07.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Jzbkk-0000b2-00; Fri, 23 May 2008 20:12:30 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080513002409.GC29038@spearce.org>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX18Ev0bsLQUHKR5v5wZw3q+Uf8uZL9ktFfH2nOMo
	h/Q4QXneaOgubDw9dXTWG+QJO8dsHgBr1XIA8Be8EokzmmZZiA
	zf35jkb0a7bsstacHmdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82724>

>> +	 * 
>> +	 * @param directory
>> +	 *            the path which should be checked.
>> +	 * @return true if the path is a valid git repository.
>> +	 */
>> +	private static boolean isRepository(File directory) {
>> +		if (!directory.isDirectory()) {
>> +			return false;
>> +		}
> 
> We usually omit { and } on simple conditions like this.  Its a coding
> pattern we stole from C Git, which stole it from the Linux kernel.

I used this style once too, but was convinced that it dangerous to do so.

The following looks correct at the first look, but it's not:

	if (a)
		if (b)
			something;
	else
		something;

this can't happen if you use { and }:
	if (a) {
		if (b) {
			something0();
		}
	} else {
		something1();
	}


Also it is better extenable:

if (a) {
	something0();
}

if (a) {
	something0():
+	something1();
}

compared too:

-if (a)
+if (a) {
	something0();
+	something1();
+ }


it's even possible that someone does it wrong:
if (a)
	something0():
	something1();

I changed it at placed I edited to the short form, but if it is ok for 
you then I would write it the long way.

> 
>> +	private static WorkTree findWorkTree(File directory) throws IOException {
>> +		File currentDirectory = directory.getAbsoluteFile();
>> +		while (true) {
>> +			final File commonGitDirectory = new File(directory,
>> +					REPOSITORY_DIRECTORY_NAME);
>> +			if (isRepository(commonGitDirectory)) {
>> +				return new WorkTree(currentDirectory, new Repository(
>> +						commonGitDirectory));
>> +			}
>> +
>> +			if (isRepository(currentDirectory)) {
>> +				return new WorkTree(null, new Repository(currentDirectory));
>> +			}
>> +			currentDirectory = currentDirectory.getParentFile();
>> +			if (currentDirectory == null) {
>> +				throw new IOException("Can't find git repository");
>> +			}
>> +		}
> 
> Would this perhaps be a shorter, easier to follow variant of the
> same algorithm?
> 
> 	directory = directory.getAbsoluteFile();
> 	File workdir = directory;
> 	while (workdir != null) {
> 		final File gitdir = new File(workdir, REPOSITORY_DIRECTORY_NAME);
> 		if (isRepository(gitdir))
> 			return new WorkTree(workdir, new Repository(gitdir));
> 		if (isRepository(workdir))
> 			return new WorkTree(null, new Repository(workdir));
> 		workdir = workdir.getParentFile();
> 	}
> 	throw new NoGitRepositoryFoundException("No repository for " + directory);
> 

I did it this way now, but the line length limit makes it harder to read 
then my first version.
