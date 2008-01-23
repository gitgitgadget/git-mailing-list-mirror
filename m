From: Kevin Ballard <kevin@sb.org>
Subject: Re: git filter-branch should run git gc --auto
Date: Tue, 22 Jan 2008 22:03:30 -0500
Message-ID: <175DB3F7-2E39-4450-945F-E33D83EF2792@sb.org>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk> <20080119223249.8227.31460.stgit@yoghurt> <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org> <20080121224818.GA8872@untitled> <7vr6gawvkt.fsf@gitster.siamese.dyndns.org> <20080122003911.GA16453@hand.yhbt.net> <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org> <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org> <7v1w89qmw3.fsf@gitster.siamese.dyndns.org> <7vwsq1p82i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-59--588088357; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 04:04:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVuF-0006Pq-Jf
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 04:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbYAWDDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 22:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYAWDDd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 22:03:33 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:57468 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751775AbYAWDDd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 22:03:33 -0500
Received: from KBALLARD.RES.WPI.NET (KBALLARD.RES.WPI.NET [130.215.239.91])
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 30AA9EEE8D;
	Tue, 22 Jan 2008 19:03:32 -0800 (PST)
In-Reply-To: <7vwsq1p82i.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71503>


--Apple-Mail-59--588088357
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Jan 22, 2008, at 9:52 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Kevin Ballard <kevin@sb.org> writes:
>>
>>> Am I missing something, or does git-filter-branch really not do any
>>> garbage collection? I tried reading the source, but complex bash
>>> scripts are almost as bad as perl in terms of readability.
>>
>> Theoretically yes, and it largely depends on what you do, but
>> filter-branch goes over the objects that already exists in your
>> repository, and hopefully you won't be rewriting majority of
>> them.
>>
>> So the impact of not repacking is probably much less painful in
>> practice.
>>
>> But again as I said, it largely depends on what you do in your
>> filter.  If you are upcasing (or convert to NFD ;-)) the
>> contents of all of your blob objects, you would certainly want
>> to repack every once in a while.
>
> Something like this, perhaps?
>
> git-filter-branch.sh |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index ebf05ca..8e44001 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -299,6 +299,12 @@ while read commit parents; do
> 			die "msg filter failed: $filter_msg"
> 	sh -c "$filter_commit" "git commit-tree" \
> 		$(git write-tree) $parentstr < ../message > ../map/$commit
> +
> +	if test $(( $i % 512 )) = 0
> +	then
> +		git gc --auto
> +	fi
> +
> done <../revs
>
> # In case of a subdirectory filter, it is possible that a specified  
> head
>


Offhand that looks good, but we'd probably want to unilaterally do  
another git-gc when we're done.

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ebf05ca..32274a6 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -299,8 +299,16 @@ while read commit parents; do
  			die "msg filter failed: $filter_msg"
  	sh -c "$filter_commit" "git commit-tree" \
  		$(git write-tree) $parentstr < ../message > ../map/$commit
+
+	if test $(( $i % 512 )) = 0
+	then
+		git gc --auto
+	fi
+
  done <../revs

+git gc --auto
+
  # In case of a subdirectory filter, it is possible that a specified  
head
  # is not in the set of rewritten commits, because it was pruned by the
  # revision walker.  Fix it by mapping these heads to the next  
rewritten


-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-59--588088357
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTIzMDMwMzMxWjAjBgkqhkiG9w0BCQQxFgQUleRPt+5ZH6Z31wD8PB62aV11tXswgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAAXmQkrfT27ZaY7WGDFIjdUosX/YWrCwedZDu0HqvtIZxMWCJC/8hpMMLMv5k/V64IgcVLZ/
voRlSxEH08ObV+EoKv0/ESIqC84DNnK3MxfGKJx2MsgZIIhpbEULFOtICOoNRtl2iQ7Z0/nAfEjF
921r+H/PYWwgThxZgQQ4gCvyzmcAwNVceAaF/Y1dWI0Ntl4vapXw26CLzMA2ag5DCxUnOba1y5sh
QcHpBKUtIg2/rXFiNINUFeCc/gsivYPfxQyAY0lcTspHk76VjxQ63CXTMO1lH+egjYcTC307ZKtG
CUEMk4xrDFbh5F9y13b+hxtVq60csuT+3BmVvUMxEVMAAAAAAAA=

--Apple-Mail-59--588088357--
