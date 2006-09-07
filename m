From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Change set based shallow clone
Date: Thu, 7 Sep 2006 15:52:59 -0400
Message-ID: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 21:53:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLPvx-0003Z5-Un
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 21:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWIGTxE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 15:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWIGTxE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 15:53:04 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:54101 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751838AbWIGTxA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 15:53:00 -0400
Received: by py-out-1112.google.com with SMTP id n25so473809pyg
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 12:53:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oQaEZ8NmBCfnLgDgayKTyOFuTSwXdtJdK6oS8DkH3wcCgs5+LvhFYI5lDMYOVorneCl91xd3++RFZzFtNpJ4hzCa5cQUz7DSBkvk4cJ2geGHmz0fJKGbSgVzc8Mr5vpMJya08mNqBifFRjf2997j6tVXO1tSacCBbtuQ6NNJ2Pw=
Received: by 10.35.61.17 with SMTP id o17mr1342687pyk;
        Thu, 07 Sep 2006 12:52:59 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 7 Sep 2006 12:52:59 -0700 (PDT)
To: git <git@vger.kernel.org>, "linux@horizon.com" <linux@horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26653>

Here's a change set based shallow clone scheme I've been thinking
about, does it have potential?

When the client wants a shallow clone it starts by telling the server
all of the HEADs and how many change sets down each of those HEADs it
has locally. That's a small amout of data to transmit and it can be
easily tracked. Let's ignore merged branches for the moment.

The client then says I want at least 10 (or N) change sets for all of
the HEADs present at the server.  The server starts from each HEAD and
works backwards until it encounters a change set present on the
client. At that point it will be able to compute efficient deltas to
send.

If you haven't updated for six months when the server walks backwards
for 10 change sets it's not going to find anything you have locally.
When this situation is encountered the server needs to generate a
delta just for you between one of the change sets it knows you have
and one of the 10 change sets you want. By generating this one-off
delta it lets you avoid the need to fetch all of the objects back to a
common branch ancestor. The delta functions as a jump over the
intervening space.

In the case of an initial shallow clone the client won't have anything
to delta against.  The server will be forced to send a full version
for one of the 10 change sets requested and deltas for the rest.
Getting an initial shallow clone should take about as long as a CVS
check out.

This scheme does require the server to sometimes generate custom diffs
for the client, but in all the cases I have been working with
everything is always IO bound so it is better to spend some CPU to
reduce the IO needed.

-- 
Jon Smirl
jonsmirl@gmail.com
