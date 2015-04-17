From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2 0/4] UTF8 BOM follow-up
Date: Sat, 18 Apr 2015 00:44:50 +0200
Message-ID: <55318CE2.1000706@gmail.com>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com> <1429209548-32297-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 00:44:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjF0H-00011Q-9V
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 00:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbbDQWot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 18:44:49 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35037 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbDQWos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 18:44:48 -0400
Received: by widdi4 with SMTP id di4so37737075wid.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=B2YcwhTDLT2zAar/FMvDrhZfzb3Lrhjm7HjWVKN0go4=;
        b=XmRRobDeEvS+yq+zO5c/B83TUJIiLeg88x9JNlcYDXBbLfcs3UZJ88wosbWWtBI+Ug
         6gDTBqO45uQiuqKLCveB0CjRkBfrYbD6S9xNJocGmKfrsw+IvuYE78rR7TFD1kOcb/4X
         FT1VyTHu3axF7bOpfkBTtdtdGX1gWx7CRj+FTZ+MbTkIzN55E12YK9hV1W5JlLn3/c0g
         zkolmJObd6NBXVLZ/1I+Bd3ogovpVZ7QAlFRO4XwdjMtsC1yN0vpmZ/XIR2yaMhoeKWN
         2YZKGgU+2wjcXyQkKatpkdoMpZbPPLE2aGTrS1Im39qpACTuQnYSpc0FccrXcqNCbVnL
         OsMQ==
X-Received: by 10.180.19.134 with SMTP id f6mr5060877wie.35.1429310687409;
        Fri, 17 Apr 2015 15:44:47 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id uo6sm16441220wjc.49.2015.04.17.15.44.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2015 15:44:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1429209548-32297-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267399>

Am 16.04.2015 um 20:39 schrieb Junio C Hamano:
> This is on top of the ".gitignore can start with UTF8 BOM" patch
> from Carlos.
> 
> Second try; the first patch is new to clarify the logic in the
> codeflow after Carlos's patch, and the second one has been adjusted
> accordingly.
> 
> Junio C Hamano (4):
>   add_excludes_from_file: clarify the bom skipping logic
>   utf8-bom: introduce skip_utf8_bom() helper
>   config: use utf8_bom[] from utf.[ch] in git_parse_source()
>   attr: skip UTF8 BOM at the beginning of the input file
> 


Wouldn't it be better to just strip the BOM on commit, e.g. via a clean filter or pre-commit hook (as suggested in [1])? Or is this patch series only meant to supplement such a solution (i.e. only strip the BOM when reading files from the working-copy rather than the committed tree)?


According to rfc3629 chapter 6 [2], the use of a BOM as encoding signature should be forbidden if the encoding is *known* to be always UTF-8. And .gitignore, .gitattributes and .gitmodules contain path names, which are always UTF-8 as of Git for Windows v1.7.10.

IOW, allowing a BOM would mean that files *without* BOM are *not* UTF-8 and need to be decoded from e.g. system encoding (which unfortunately cannot be set to UTF-8 on Windows). But this makes no sense as the repository would not be portable. E.g. a .gitattributes file created on a Greek Windows, containing greek path names in Cp1253, would not work on platforms with different encoding.

On the other hand, just ignoring the BOM (as this patch series does) leaves us with two alternative binary representations of the same content file...i.e. we'll eventually end up with spurious 1st line changes as users add / remove BOMs from committed .git[ignore|attributes|modules] files, depending on their editor preference...


For local files (.gitconfig, .git/info/exclude, .git/COMMIT_EDITMSG...), auto-detecting encoding based on the presence of a BOM makes somewhat more sense. However, this will most likely break editors that follow the recommendation of the Unicode specification ("Use of a BOM is neither required nor recommended for UTF-8" [3]). So we'd probably need a core.editorEncoding or core.editorUseBom setting to tell git whether "no BOM" means UTF-8 or system encoding...

Just as a reminder: we should update the Git for Windows Unicode document [4] if we improve support for BOM-adamant editors.

Cheers,
Karsten

[1] http://stackoverflow.com/questions/27223985/git-ignore-bom-prevent-git-diff-from-showing-byte-order-mark-changes
[2] https://tools.ietf.org/html/rfc3629
[3] http://www.unicode.org/versions/Unicode7.0.0/ch02.pdf  p.40
[4] https://github.com/msysgit/msysgit/wiki/Git-for-Windows-Unicode-Support#editor
