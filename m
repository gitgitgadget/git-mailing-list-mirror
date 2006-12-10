X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 23:05:36 +0100
Message-ID: <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
	 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
	 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:05:58 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QE+OzHTJDQqtCAuXX8ZftDT+gnYWeYkrmcxzrPLf1Cp7DhdsywZbUakrujz/fcxl7AeNFj5z828I0upBL/p3AAdHi7zhjaBQ0muP8XQo+VPqusrQxFheLwdX6+pt21S3foJRVVBDzfm7FhhMZ7eFpn1UasdIoUQ+la8kL/fGgro=
In-Reply-To: <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33936>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWns-00082e-Aa for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935226AbWLJWFi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935379AbWLJWFi
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:05:38 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:24904 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S935226AbWLJWFg (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 17:05:36 -0500
Received: by py-out-1112.google.com with SMTP id a29so794767pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 14:05:36 -0800 (PST)
Received: by 10.35.39.13 with SMTP id r13mr8550574pyj.1165788336203; Sun, 10
 Dec 2006 14:05:36 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 10 Dec 2006 14:05:36 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>

> data into ASCII etc. So temp-files are almost never a better solution than
> keeping things in memory (unless you use those temp-files to truly
> _share_ data between processes, ie you do a shared mmap and they can
> re-use the same pages actively in a way they couldn't otherwise).
>

Ok. Perhaps I'm doing something wrong but the following code it's
always 10% slower then the temporary file one (4.7s against 4.3s for
linux tree)

bool DataLoader::start(const QStringList& args, const QString& workDir) {

	QDir::setCurrent(workDir);

	_file = popen(args.join(" ").ascii(), "r");
	if (!_file)
		return false;
	
	loadTime.start();
	guiUpdateTimer.start(10, true); // will call on_timeout() in 10ms
	return true;
}

void DataLoader::on_timeout() {

	if (canceling)
		deleteLater();

// 	int fd = fileno(_file);    // read() case

	ssize_t len = 0;
	while (1) {

		QByteArray* ba = new QByteArray(FILE_BLOCK_SIZE); // 64KB

// 		len = read(fd, ba->data(), ba->size());        // read() case

		len = fread(ba->data(), 1, ba->size(), _file); // fread() case
		if (len <= 0) {
			delete ba;
			break;

		} else if (len < (ssize_t)ba->size()) // very rare, 4 out of 40000
on Linux tree
			ba->resize(len);

		loadedBytes += len;
		fh->rowData.append(ba); // fh->rowData it's a pointer's list
		parseSingleBuffer(ba);

		// avoid reading small chunks if data producer is still running
		if (len < FILE_BLOCK_SIZE)
			break;
	}

// 	if (len == 0) {         // read() case
	if (feof(_file)) {      // fread() case
	
		emit loaded(fh, loadedBytes, loadTime.elapsed(), true, "", ""); //
show some stats

		pclose(_file);
		_file = NULL;
		deleteLater();
	} else
		guiUpdateTimer.start(100, true); // next read in 100ms	
}

Uncomment 'read() case' lines and comment out the 'fread case()' ones
and you have a way slooooower code, about 10 times slower!


