From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit shows wrong popup
Date: Fri, 13 Jan 2006 18:41:25 +0100
Message-ID: <43C7E645.2050702@yahoo.it>
References: <1137021690.10975.22.camel@dv> <e5bfff550601120455p1b1654cx43beb684a3fd5dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 13 18:42:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExSvo-0004fD-9A
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 18:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWAMRlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 12:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWAMRll
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 12:41:41 -0500
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:21889 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1422739AbWAMRll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 12:41:41 -0500
Received: (qmail 64425 invoked from network); 13 Jan 2006 17:41:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yOEPnharUn6Clj1ofsZw0/4TbkB2bdoHSsPod7BDNOhY6LATtGVGi9Bpo1MSLE5NYovJINSrLzkduuJNjnXOED9wO6UdHXVBPlnAQOz0AroBEOyIO9BMDm/HIMD3zbsGps5ffYDUF1UPSsRrtVYBTvlN0U5TQARONj4wnWTSk3g=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.56.59.246 with plain)
  by smtp107.mail.sc5.yahoo.com with SMTP; 13 Jan 2006 17:41:38 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <e5bfff550601120455p1b1654cx43beb684a3fd5dc7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14633>


>>I found this comment in mainimpl.cpp:
>>  // call an async context popup, DO NOT filter out event
>>  // we append the event to main event loop queue so Qt can send
>>  // currentChanged() signal to listViewLog before our popup is
>>populated
>>
>>I guess the code doesn't work the way the comment says.
>>
Hi Pavel,

please test the following an let me know if it is ok for you.

@@ -1378,9 +1378,21 @@ void MainImpl::customEvent(QCustomEvent*
  	if (e->type() == STATS_EV) // archive loading complete
  		loadComplete(((ThreadStatsEvent*)e)->data());

-	if (e->type() == POPUP_EV) // deferred popup
-		doContexPopup(listViewLog->currentItem());
-
+	if (e->type() == POPUP_EV) { // deferred popup
+		QListViewItem* item = listViewLog->currentItem();
+		if (item) {
+			// if mainview is already updated pop-up
+			// context menu, otherwise it means dispatch()
+			// has not been called til now, so resend the event,
+			// it will be queued up after dispatch.
+			if (item->text(COMMIT_COL) == mainViewSha)
+				doContexPopup(listViewLog->currentItem());
+			else {
+				DeferredPopupEvent* e = new DeferredPopupEvent();
+				QApplication::postEvent(this, e);
+			}
+		}
+	}
  	if (e->type() == POPUP_TREE_EV) // deferred tree popup
  		doTreeContexPopup(treeView->currentItem());



	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
