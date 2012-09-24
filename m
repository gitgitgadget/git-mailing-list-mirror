From: =?windows-1252?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive --format zip utf-8 issues
Date: Mon, 24 Sep 2012 17:56:57 +0200
Message-ID: <506082C9.6050604@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net> <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org> <5047A9C0.9020200@lsrfire.ath.cx> <5058CE49.3070108@lsrfire.ath.cx> <7v1uhzkpcc.fsf@alter.siamese.dyndns.org> <505B91E9.7060208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030900030306070908050502"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Sep 24 17:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGB2G-0006WJ-BT
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 17:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab2IXP5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 11:57:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:43296 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633Ab2IXP5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 11:57:18 -0400
Received: from [192.168.2.105] (p4FFD913E.dip.t-dialin.net [79.253.145.62])
	by india601.server4you.de (Postfix) with ESMTPSA id 564CB28B;
	Mon, 24 Sep 2012 17:57:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <505B91E9.7060208@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206289>

This is a multi-part message in MIME format.
--------------030900030306070908050502
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I found a way to make unzip respect the UTF-8 flag in ZIP files: 
Apparently (from looking at the source) an extended field needs to be 
present in order for it to even look at general purpose flag 11.  I sent 
a patch to add an extended timestamp field that fits the bill.

Here are new numbers on ZIP international filename compatibility:

		7-Zip	PeaZip	builtin	unzip	unzip	unzip	7z
		Windows	Windows	Windows	Linux	mingw	Windows	Linux
git	Linux	1	1	1	7	1	1	1
git 1	Linux	37	37	1	7	1	1	37
git 2	Linux	37	37	1	37	1	1	37
git 3	Linux	37	37	1	37	15	15	37
git	mingw	1	1	1	7	1	1	1
git 1	mingw	37	37	1	7	1	1	37
git 2	mingw	37	37	1	37	1	1	37
git 3	mingw	37	37	1	37	15	15	37
7-Zip	Windows	37	37	14	24	15	15	24
PeaZip	Windows	37	37	14	24	15	15	24
zip	Linux	37	37	1	37	15	15	37
zip	Windows	14	14	0	37	15	15	1
builtin	Windows	14	14	14	1	14	14	1

The test corpus still consists of 37 files based on the pangrams on the 
following web page:

	http://www.columbia.edu/~fdc/utf8/index.html#quickbrownfox

The files can be created using the attached script.  It also provides a 
check command to count the files with correct names, and the results of 
that for different ZIP extractors are give in the table.  The built-in 
ZIP functionality on Windows was only able to pack 14 of the 37 files, 
which explains the low score across the board for this packer.

"git 1" is the patch "archive-zip: support UTF-8 paths" added, which 
let's archive-zip make use of the UTF-8 flag.  "git 2" is "git 1" plus 
the patch "archive-zip: declare creator to be Unix for UTF-8 paths". 
Both have been posted before.  "git 3" is "git 1" plus the new patch 
"archive-zip: write extended timestamp".

Let's drop patch 2 (Unix as creator) and keep patches 1 (UTF-8 flag) and 
3 (mtime field) to make archive-zip record non-ASCII filenames in a 
portable way.  It's not perfect, but I don't know how to do any better 
given that Windows' built-in ZIP functionality expects filenames in the 
local code page and with an international audience for projects 
distributing ZIP files.

Ren�


--------------030900030306070908050502
Content-Type: text/plain; charset=windows-1252;
 name="pangrams.sh"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="pangrams.sh"

#!/bin/sh

files() {
cat <<EOF
pangrams/わがよたれぞ　つねならむ
pangrams/うゐのおくやま　けふこえて
pangrams/いろはにほへど　ちりぬるを
pangrams/あさきゆめみじ　ゑひもせず
pangrams/An ḃfuil do ċroí ag bualaḋ ó ḟaitíos an ġrá a ṁeall
pangrams/Árvíztűrő tükörfúrógép
pangrams/Blåbærsyltetøy
pangrams/D'ḟuascail Íosa Úrṁac na hÓiġe Beannaiṫe pór
pangrams/d'œufs abîmés
pangrams/Éava agus Áḋaiṁ
pangrams/Eĥoŝanĝo ĉiuĵaŭde
pangrams/El pingüino Wenceslao hizo kilómetros bajo exhaustiva
pangrams/Falsches Üben von Xylophonmusik quält
pangrams/Flygande bäckasiner söka strax hwila på mjuka tuvor
pangrams/Høj bly gom vandt fræk sexquiz på wc
pangrams/jeden größeren Zwerg
pangrams/lena ṗóg éada ó ṡlí do leasa ṫú
pangrams/Les naïfs ægithales hâtifs pondant à Noël où il gèle
pangrams/lluvia y frío añoraba a su querido cachorro
pangrams/na stĺpe sa ďateľ učí kvákať novú ódu o živote
pangrams/O próximo vôo à noite sobre o Atlântico
pangrams/Pa's wĳze lynx bezag vroom het fikse aquaduct
pangrams/Pchnąć w tę łódź jeża lub osiem skrzyń fig
pangrams/põe freqüentemente o único médico
pangrams/Příliš žluťoučký kůň úpěl ďábelské kódy
pangrams/Sævör grét áðan því úlpan var ónýt
pangrams/sont sûrs d'être déçus en voyant leurs drôles
pangrams/Starý kôň na hŕbe kníh žuje tíško povädnuté ruže
pangrams/The quick brown fox jumps over the lazy dog
pangrams/Törkylempijävongahdus
pangrams/Vuol Ruoŧa geđggiid leat máŋga luosa ja čuovžža
pangrams/זה כיף סתם לשמוע איך תנצח קרפד עץ טוב בגן
pangrams/ξεσκεπάζω την ψυχοφθόρα βδελυγμία
pangrams/ξεσκεπάζω τὴν ψυχοφθόρα βδελυγμία
pangrams/Жълтата дюля беше щастлива
pangrams/Съешь же ещё этих мягких французских булок да выпей чаю
pangrams/че пухът, който цъфна, замръзна като гьон
EOF
}

case "$1" in
create)
	mkdir -p pangrams
	files | while read file
	do
		touch "$file"
	done
	;;
check)
	files | while read file
	do
		test -f "$file" && echo "$file"
	done | wc -l
	;;
*)
	echo "Usage: $0 create | check" >&2
	exit 1
	;;
esac

--------------030900030306070908050502--
