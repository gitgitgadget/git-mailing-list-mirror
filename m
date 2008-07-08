From: Tarmigan <tarmigan+git@gmail.com>
Subject: git push to amazon s3 [was: [GSoC] What is status of Git's Google Summer of Code 2008 projects?]
Date: Mon, 7 Jul 2008 22:48:59 -0700
Message-ID: <905315640807072248w44ccdc4y2f1cf54a10c50c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marek Zawirski" <marek.zawirski@gmail.com>, git@vger.kernel.org,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Nick Hengeveld" <nickh@reactrix.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 07:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG65S-0006bp-TD
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbYGHFtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 01:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYGHFtD
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 01:49:03 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:40583 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbYGHFtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 01:49:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1325094fkq.5
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=jc/mLGcLvhkITROOaI4Bq3UpiZNaICYtke1d+rDo8VU=;
        b=ZDVN03xd/FJdDDz6Dq7G32CoX84jMj9pZbHyyDJsSEJfiDMhCDme915JhmcoDPf8N6
         Eym1EPDQ/ObMzAv7XXzlIP9FCiQmliJKCA7BY0m1wk5fVIYlu7pX9v7iTEa8QpUUnZCW
         OrOU8VM/D8XI44zjzxpYem2LyBfhD8ceogJ2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=YDzyafxlusacSvf4XQ68THZYgPWD/mYXCHx6OHp8PPy785IksLK0aX2TvDm221tk0D
         p1ge5APiAmJqfTLAdIvUb720p0IqjQ815q0RtcU9LoiQ0LLejnWq9AsWX8DnZCG2gWYm
         xrIOU2RT93yxmLEK1BMF8cJYKKIAWLeOSZ27k=
Received: by 10.125.83.17 with SMTP id k17mr1152642mkl.78.1215496139471;
        Mon, 07 Jul 2008 22:48:59 -0700 (PDT)
Received: by 10.125.99.6 with HTTP; Mon, 7 Jul 2008 22:48:59 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: a58fd8cfec2f1a88
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87719>

(trimmed cc list to folks who've touched http-push.c)

On Mon, Jul 7, 2008 at 9:19 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Using Marek's pack generation code I added support for push over
> the dumb sftp:// and amazon-s3:// protocols, with the latter also
> supporting transparent client side encryption.
>
> I chose to add these features to jgit partly as an exercise to prove
> that Marek's code was built well enough to be reused for this task,
> partly because I wanted to backup some private personal repositories
> to Amazon S3, and partly to prove that multiple dumb transports
> could implement push support.

That sounds cool.  I've been looking into adding s3 push into cgit,
and was looking into modifying http-push.c, but got in over my head.
I had trouble trying to make it fit into the DAV model that http-push
is built around, in part because s3 doesn't seem to support any
locking and a lot of the http-push code seems to be around the
locking.

Can you describe the s3 support that you added?  Did you do any
locking when you pushed?  The objects and packs seem likely to be
naturally OK, but I was worried about refs/ and especially
objects/info/packs and info/refs (fetch over http works currently out
of the box with publicly accessable s3 repos).

Thanks,
Tarmigan

PS For anyone else who's interested, here's some instructions on how I
got started with s3 and git:

Start by creating an amazon s3 account

Next download and install "aws" from http://timkay.com/aws/
Set it up and install your amazon keys as specified.

# I setup a bucket named git_test.
s3mkdir git_test

#  Run this script to upload a git repo to amazon (run
update-server-info first):
#!/bin/bash
for i in $(tree -fi --noreport git_test_orig.git) ; do
    #exclude directories
    if [ ! -d $i ] ; then
        echo $i
        s3put "x-amz-acl: public-read" git_test/ $i
    fi
done

# Then you can clone (really, feel free to clone from this url.  It
should just work):
git clone http://s3.amazonaws.com/git_test/git_test_orig.git

# This experimenting on the git.git repo will set you back about US$0.05
