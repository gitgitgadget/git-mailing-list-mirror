From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: git pack protocol question: sideband responses in case of errors?
Date: Wed, 13 May 2015 11:03:51 +0200
Message-ID: <CAENte7j9De5Bqu2jDcmXQAxZheSGo+EntzsYUaen0N7cnuiCDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>, Shawn Pearce <sop@google.com>
X-From: git-owner@vger.kernel.org Wed May 13 11:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSaR-0001H2-Nk
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbbEMJEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:04:14 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34849 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbbEMJEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:04:12 -0400
Received: by widdi4 with SMTP id di4so188987038wid.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=8mYfZVeyS7xUmtvbFLXbyFriR5rVFPieeAi9l06camM=;
        b=DsRHQlQar9sYXLaPRb6B8QvtPkYegVUZMT96JCkRBo4WITZXWPVLfbs3t9CuJ7CcTj
         wNpKmqUpVC5fO3IKAL7uLHKPSumbHo4XqiNEJ2YEcilagcEXwGTQq4Dyp8Q5ulLgx/WC
         WR+YgpY4rzV3NGmkvNO2ghG9relcghI1lI0Evq0PLOs5oc578QhZuTwSmnPycpVwB3bt
         wMtuvQyPEZhstwbcxs3xCT3e6rhj/xQcw08pUAP3CuOoASrAZpNL2JEqqtMlbRImy130
         zKkUpmAXFxyoWw1LjC/rpi8ZV7wG91/C1aea8Cqp7R1XBJ8H3gANd3a0e47VAnDyRuAA
         aI6A==
X-Received: by 10.180.82.135 with SMTP id i7mr38349547wiy.68.1431507851554;
 Wed, 13 May 2015 02:04:11 -0700 (PDT)
Received: by 10.194.23.42 with HTTP; Wed, 13 May 2015 02:03:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268949>

Hi,

since a long time I am hitting very seldom errors when pushing with a
jgit client leading to "invalid channel 101" errors on client side. I
was always wondering why it was always the channel "101". Now I found
out with wireshark and it leads me to a question regarding the git
pack protocol [1] and the sideband capability [2] which I couldn't
answer from the technical docs.

This is what happened: A client wants to push over http to a git
server. In the beginning they negotiated to use side-band-64k and
report-status capabilities. Everything works fine, Packfile data
transmission starts and sideband communication is ok. Now the server
hits a severe problem persisting the packfile and wants to stop the
transport. The git server hit's quotas on the filesystem usage and is
not allowed to persist that big file. My git server (I use a modified
gerrit server) intends to send back a packet line "0013error: ...".
But the client when reading that respond still thinks we should use
sideband communication and interpretes the "e" from "error" as
channel. The ascii code of "e" is the solution why it was always
"invalid channel 101"

Here is my question:
- When exactly should sideband communication during a http based push
start and when should it end? Especially in case of an error on the
server side. Is the server allowed to switch to non-sideband
communication under special conditions? E.g. when the server responds
not with 200OK but with 413 (entity too large).
- Is responding with status code 200 mandatory when talking git pack
protocol? Am I allowed as git server to respond with status code 413
and fill the body of the response with the status report?

Ciao
  Chris

[1] https://raw.githubusercontent.com/git/git/master/Documentation/technical/pack-protocol.txt
[2] https://raw.githubusercontent.com/git/git/master/Documentation/technical/protocol-capabilities.txt
