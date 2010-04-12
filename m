From: Debayan Banerjee <debayanin@gmail.com>
Subject: Rename similarity scoring for file pair
Date: Mon, 12 Apr 2010 23:42:59 +0530
Message-ID: <t2ua2cc2dbc1004121112h64f5b61ela57f5fa83abf51f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 12 20:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1O8V-0006Iw-7h
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 20:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab0DLSNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 14:13:20 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:33734 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab0DLSNT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 14:13:19 -0400
Received: by pzk42 with SMTP id 42so4023485pzk.4
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=/SNgm/8g8Y6Vg2AwTXv2LNoz7QBYIXK8V86BIIwWx8w=;
        b=ZZ2U6gtm+Sr7AIUYgqeRZmS20t/Sd/8s7H3m5XmGiX8IKOL7y98uXurCR072ukcDAC
         E44/e66cSH5HFEgbOrBn1uGGz254Bo0tbPGhjILvjXqO7/obud3xjsm6u7IbvrVK0D4E
         3mEKtUkoaDteL9Fwrq8bH/PoNro2h+qg+fVtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=G2YB+xRSonsYPY4Zfe70UoGsZD8j4YhX6eNdN78iyG6fv5S5w673y+nUfZTTxAwwUN
         GwviXK99f2zuEbZGUQdEhL1HmjalbLHZO/ETqfOUN/Us7vDLmCwdfRiPkL4TCPqL4TqT
         VYDrXrMvKUdMwwveET+4Mr781UJLMPfJBH1Q4=
Received: by 10.141.37.12 with HTTP; Mon, 12 Apr 2010 11:12:59 -0700 (PDT)
Received: by 10.140.58.10 with SMTP id g10mr4107286rva.85.1271095999464; Mon, 
	12 Apr 2010 11:13:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144761>

I was going through this thread
<http://markmail.org/message/mge2spy7uqle5ghy#query:diffcore-rename.c%20algorithm+page:1+mid:ji7jkzypzqpml2xn+state:results>
trying to understand how the similarity scoring for modified files
works. I see that the algorithm uses two hashes, one for each file,
and proceeds to compare the 2 hashes to determine percentage
similarity.
I think I have an algorithm which uses only one hash and has a worst
case space complexity of O(N) where N is the number of lines
inserted/deleted/moved.
The algorithm is as follows:

def similarity(leftFileContent, rightFileContent)
{
	int lineCounter = 0;
	struct HashElement  {
	HashElement(): leftFileCount(0), rightFileCount(0) // One of these
counters will remain 0 for its lifetime. The other will be >=0
		int leftFileCount; // Increment if line is from leftFile
		int rightFileCount; // Increment if line is from right file.
	};
	Hash<lineContent, HashElement> hash; //One hash for both files
	int similartyCounter = 0;
	while(true)  {
		leftLline = leftFileContent[lineCounter];
		rightLine = rightFileContent[lineCounter];
		if (hash.contains(leftLine))  {
			HashElement h = hash.value(leftLine);
			if (h.leftFileCount > 0)   {//The previous occurence has come from
the left file
				h.leftFileCount++;  //This line is another occurence of the same
line in the same file. So we increment the counter.
			}
			else  {
				h.leftFileCount--;
				similarityCounter++;  //Hey, this line matched an earlier
occurence from the other file!
			}
			if (h.leftFileCount == 0 && h.rightFileCount == 0)
				hash.remove(leftLine);			
		}
		else  { // this line is being encountered for the first time, so add
it to the hash
			HashElement h;
			h.leftFileCount++;
			hash.add(leftLine, h);
		}
		
		if (hash.contains(rightLine))  {
			HashElement h = hash.value(rightLine);
			if (h.rightFileCount > 0)   {//The previous occurence has come from
the right file
				h.rightFileCount++;  //This line is another occurence of the same
line in the same file. So we increment the counter.
			}
			else  {
				h.rightFileCount--;
				similarityCounter++;  //Hey, this line matched an earlier
occurence from the other file!
			}
			if (h.leftFileCount == 0 && h.rightFileCount == 0)
				hash.remove(line2);			
		}
		else  { // this line is being encountered for the first time, so add
it to the hash
			HashElement h;
			h.rightFileCount++;
			hash.add(line2, h);			
		}
		lineCounter++;
		if (lineCounter == leftFileContent.size() || lineCounter ==
rightFileContent.size())
			break;
	}
	/* Upto this point we have processed an equal number of lines in both
the files simultaneously. Now we may have a file which is
	larger in size than the other. We need to process the remanant of this file*/
	bool leftFileIsLonger;
	FileContent fileContent;
	int size;
	if (leftFileContent.size() == rightFileContent.size())		
		return ((similarityCounter*100) / rightFileContent.size());
	if (leftFileContent.size() >rightFileContent.size())  {
		leftFileIsLonger = true;
	        fileContent = leftFileContent; //fileContent should really be
 a pointer to leftFileContent
		size = leftFileContent.size();
        }
	else  {
		leftFileIsLonger = false;
		fileContent = rightFileContent; //fileContent should really be  a
pointer to rightFileContent
		size = rightFileContent.size();
	}
	for (i = lineCounter + 1;  i < size; i++ )  {
		line = fileContent[i];
		if (hash.contains(line))  {
			Hash h = hash.value(line);
			if (h.leftLineCount > 0)  { //Line in hash came from left file
				if (leftFileIsLonger)
					h.leftFileCount++; //Even this line came from the same file, so
its just a repeated line.
				else  {
					h.leftFileCount--;
					similarityCounter++;  //This line came from the right file, so
increase similarityCounter and decrease the leftCounter.
				}
			}
			else  { //Line in hash came from right file
				if (leftFileIsLonger)  {
					h.rightFileCount--;
					similarityCounter++;
				}
				else
					h.rightFileCount++;
			}
			if (h.leftFileCount == 0 && h.rightFileCount == 0)
					hash.remove(line);
		}
	}
    return ((similarityCounter*100) / size); //Formula for calculating
similarity is same as git uses
}

--
Debayan Banerjee
Software Engineer
