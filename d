Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_05,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0E21FF76
	for <e@80x24.org>; Mon, 26 Dec 2016 12:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754571AbcLZMi3 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 26 Dec 2016 07:38:29 -0500
Received: from mail-db5eur01on0107.outbound.protection.outlook.com ([104.47.2.107]:10112
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753935AbcLZMi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 07:38:27 -0500
X-Greylist: delayed 7260 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Dec 2016 07:38:27 EST
Received: from SmtpServer.Submit by VI1PR0101MB1616 with Microsoft SMTP Server
 id 15.1.803.11; Mon, 26 Dec 2016 02:00:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
From:   Service Desk <isd-noreply@ucl.ac.uk>
To:     <git@vger.kernel.org>
Subject: Warning: You tried to send an email with blocked content
Content-Transfer-Encoding: 8BIT
Message-ID: <03cfb545-8e91-4132-b30a-d5a3f6d7eed0@VI1PR0101MB1616.eurprd01.prod.exchangelabs.com>
Date:   Mon, 26 Dec 2016 02:00:40 +0000
X-MS-Exchange-Parent-Message-Id: <148271762999.4343.17263403035894855886@lancernet.com.br>
Auto-Submitted: auto-generated
X-MS-Exchange-Generated-Message-Source: DC Pre Content Filter Agent
X-MS-Office365-Filtering-Correlation-Id: 0a9fe046-7cd3-4544-6ca7-08d42d32fe1c
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB1616;25:uRR+7eXjGaO/J2ygMUrWz2fGrpp3zAXp3VcO1gZsZc/DsIhBzDwi8qd+9dc3Qn/GYKNXafL0xxohMhEvv4aAX/Y0gyJzCBEgW1OjMlkkAsuctzYKfKSGjs7rSRXa16tVH1YxkZUFOm9vxgG8JGYHIxi69JS8F6kqzkDypsZUh/Ph9a9gGWxX1my0jDg2HxxHMbXe3m7kJBslAx5b0zeJ/apt63o4bQe7U0zYbAP2udrJMTn3q2ja9CHUh09e3cbvCPmvk4gfcgNy/Y1E4CtnXNBtmOA3CzdLdzxhUbOPGVu4mJywOu4moTLRiM9e5UvrRlSa9/+B3LFT6kAqHZ4FUvlbG4+X0zZI5jCXo0gIvjjXiqElX41G9qFl7jD19QFZKudzovXFRG7ay1cN8cVOY/ObWu5X82XJpn8+pDgqRKSEljs+ZrwA/l+4+sW4LQJHbvaFRQndD7xRO5VrY8vy0w==;31:kLlwMmWo90QeAfWg6zHZl6FNOQMF51hWeafNYsKZDXheQEjcgUMwMkeo03jE2IocC1PjhgmpJMyK8nqKI6qhyCQNR9rwni8ZmJG0PHsqDUoSYz2LkNf6YAwaIJCNUhWmdR+eNdEYWJAD/wbwmg2qnx2bvWZDOa4vBo2Oc23ax6mDojTJFEjILeqGEzriNCb0fCHvk7QHl461ARVTSbNE4VPW+yWEldVccBxHT1AfvD3mFHhLF/BgWeD54UX0QVNAMapmginvUXpNWjGrmxm0Xw==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB1616;20:K1CZH7O7mrF1I6cRkDcoF6aLH8Y4MUX6Iy9gMjZBl8l6QdAHOE0x8HZ87FfN5D0IaNZpU15k6f7JdJEP9Cdek1pu9n2M/MRgeW1XtlLB7nZuEB93LiVnO4eeSzYhEbw4O3hZto0rrDpoIJfCz2/OOlAZhMpAYpCPtBP+wf3aiyEQVd06peuM7pcArVhOV7AFj+63Sx+O5V+cryOFl6GlzpfI81hG7XatdgqVtUucAzi6O7FovOk5W2nVzZhhnZNWYBfYbpnyH20APKZsZ7lct2zgFk9FELKrj9blEy3UtfVK+52Y6yCUEhuGer5cM2S3nfSt4q9LtHFYd2aMFutt2t6dcZsrR+M83TvveGINKmf575sA6F03OQcZLC2ZKr7kXhJxn3WWoZ8v9dn/TzPTUZvwePeo+iiNq1/SaR3vX0s29FueyCAuxCK39xWwPqXbStAdzMNmzmNE+TZSrE5onwbLTZIW+upvVkRUUpnPcHOymnPWixA4f3BO2LH9OhF0
X-Microsoft-Antispam-PRVS: <VI1PR0101MB161693C64B494CB328726D02BC960@VI1PR0101MB1616.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(166494164430575)(57025502571588);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6041248)(20161123564025)(20161123562025)(20161123555025)(20161123560025)(6072148);SRVR:VI1PR0101MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0101MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB1616;4:bSdiF5xNVOiesnStCy72N27ZwDDyvoZKZBXEJWwiNm9BoVpK2egEPZ3fEc4mnx3lBTkf24f+Qat0vM31Pit5g5kZ5swqgSRpYsqZmi96w0KqhJnPdxiDrVfgI9L6RTuScK886LbmA78QAXif1vYywfGwft5CCqhsxDS/rNhNiSuboQ8zbKzyn47f+2vH0nAZy7B1zLfGBEWVsMhH7178/Y2Ke3AdKummIQE2OKKL1AaEZk8IRMRbnXgaZgA+oJViWJ2xxdZyWzOSQA+HnQPAAYFBxsG2EKKUONDnzsi47z/9FdReZJdbYMSD9PSYy/4v8IszdOoVWD4vjEbLaXPQQ4tadONFc9VaAkLHZUNhvyf3tHctai20Qg4LXh7pbCeN9cwmb1lOIoErrBV1fd/ereo/htsPpcco4YME7/TKPTDgXyY4CZwuMYU4K+QHtg0Pi8KDtLz2Bdyg8qaNjTKcNI6QqV7iBJ9fjo3oWa8Ohk4pPJHTYr8K/e/C5UhHmUzG2tSTKjjWXiiS+Qca6eZhgiwzAAU1gB4fENx2Xl+y1m7OVYDFgi5c/uwujLM+ISkVkB2ImPdWK2H04IJoeH06noApVWThbhlloZbpxONm93o89ZxVM1adJpYqi1tCm0Cw912QCaOZ/viZYbYMZYG74RkNQivb33aL9b/G2O8537cGIiBlBMCIG8VD7m5VEHFa
X-Forefront-PRVS: 016885DD9B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(39450400003)(189002)(377454003)(199003)(50986999)(2906002)(54356999)(9686002)(2351001)(47776003)(42186005)(450100001)(92566002)(105586002)(106356001)(101416001)(38730400001)(110136003)(42882006)(33646002)(8558605004)(3110400002)(6916009)(5660300001)(15650500001)(74482002)(74316002)(1496007)(1706002)(8746002)(305945005)(107886002)(50466002)(31696002)(97736004)(189998001)(81156014)(86362001)(23676002)(8676002)(5890100001)(81166006)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0101MB1616;H:;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: ucl.ac.uk does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=isd-noreply@ucl.ac.uk; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAxMDFNQjE2MTY7MjM6b3JWMnlKOXM5dUZ4dFRHRkhaNkhkQU0z?=
 =?utf-8?B?c2tZWjVQSWVrbUxaS1BnTmpKRnMwaWtYMHIvOFlMdTJBYnpLN3FzQ2NqZ0Zh?=
 =?utf-8?B?QlpGajBzYnBkaFppN096OUJNSFZueHIyclVBMi9EUHlmRllIbDZiNHQ2c052?=
 =?utf-8?B?Ykx3cHU0SDJyR0I5dW0zQitPeER6c0cxdlV1T3FSVTB4bHFDbVhaNklsQzlI?=
 =?utf-8?B?SjRxbkpSNDBWeU9la0VkVG1OcE5ldGpkaFdWNVFuNWlEcHRzK2NRaitYYWkv?=
 =?utf-8?B?TUhzSkJkTVVObkFkK0dRNVl0U041OTVpTmFZbzlCbGIwaTNlN1dxU3ArcmVJ?=
 =?utf-8?B?S0NiaHc0Y2VzeWtxWlB6bTVUeGhaWUNZbEQyMGI1RUpDcHN0SUE0dnZXQTBM?=
 =?utf-8?B?TUZnc3NaUmdwSkZ0Y2tLdTJWc1d5NTd3bmJCbXYrd1EySURjdSs1aFZOMWFW?=
 =?utf-8?B?VndaVmxLSHVwNmIrVDBIVU9YYnRFb2NLdzBXT1F0bGg3Y2VkN2ZGV2dvL25n?=
 =?utf-8?B?SEpOd0ZEQkRlN2VsakRzTURvRnU2M0gwWUJCZ3NaL2ZFbWs1SjJlakQ4U3VP?=
 =?utf-8?B?UnlrUjczYkZPUDJkYlNDaVdGNzVmYzZxU2NhZ2FrMzlHNE9GY1ZMZnZVczEx?=
 =?utf-8?B?ejd5L0YwZllHRWtQRDZTNGkzRWM5STVSVjJoOU8yeVpSTTREbm5mWnlpbk1y?=
 =?utf-8?B?d1N6bWFwMktkZW1KazliY3FENUExU3ZxZ2R3YXVrTitrVlFQSXIySFJzUEtx?=
 =?utf-8?B?Nlp4anZyVzVqOElhdjhLTnBIOXlqRHJuS3BGVXdpODJ4VExjYkZ5bHFyemxU?=
 =?utf-8?B?TXEvMWwvczg2ZEhJRHova0U5NUVycE4yWW9NcG92ZEdGWmtob0MwQmt3anph?=
 =?utf-8?B?dWp3bDg5b1dlUmFoSjJjZHJDbG1mejNIdDYvdTlhVlVWMFNkYWZmOXliK2t4?=
 =?utf-8?B?ZzFHc3JYVGQyQ1p2NE84UE9xbXBSTDlVM1pYY0pLejRBY2xnWjFBakIvMFBT?=
 =?utf-8?B?U2dnS1JQRUo5M3V5STRJRlRTSzNtU0dudll5eERObTljeDNRb1JBUlhIRWNu?=
 =?utf-8?B?UFk0a3kzamZvbEhTTW9EbUxlWldRNkt0VWhOYzV1U2lIZlpIalBBNWp6WjM2?=
 =?utf-8?B?eW5raEErNWhqeVdFbEI5QlE5RHVJRlhNeGcyU3pVK0E5dmNJTm5JOGlmRWdr?=
 =?utf-8?B?T0lYK21ZSDI0dEh0WXRObkFCb2tmRnNVbHkzQkd1Vm5pSEVuU2ZzbVdVbCtY?=
 =?utf-8?B?UkdtRmhuNW1IWFgvOUpBcTlWMEZwdmFSTWhUYWl3WWh1NmN0V0F4dG5EY3hY?=
 =?utf-8?B?UFh2SGJ2YlM3TGUwRHpCejROWFJtc3lVVkVsODYyQURRZFhKNERYMitYZjVS?=
 =?utf-8?B?U3kyalI5TEtWNkcwT2VGNUZwMkpBN0RQcmdjTDY0UWh2K0RIcEdXdUNBeFZh?=
 =?utf-8?B?UjNrUzZhWWRJS3BzU3Q5eTUxQ011RGZCVW5ZMjZwTjEzTjc2ZHBVeU1ocklp?=
 =?utf-8?B?YzZzRGw3dXIxYk5ER21uK1ErMEVuQzZCNW1FcW51WVJIUjFLUzUyY0pqb1Ft?=
 =?utf-8?B?b29DRUgyLzAydHJkSXdBTitOZ21MQUtBdz09?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB1616;6:prZjx8yG6pRlCjVxlWw4LtitxhmSvAPVEBR7ysOHtPD5wIhl77aP7eJKWnz6S57R0Os/dNnkrwPOnKP2JBHHmt9G+wNoD4K7u79w+8+Ei3co31dBGhgOyCe0X88BwKAEbYYxuiI3gWSer3P3De66o1GNqARvn5B0gakkcbB0A+okIeU+7SEaqDMaQKrvRgGIu8sSqCLYEWWO2MZuIhnb2s7LDo1djJbmn1StozCxRA4B4LxuY1fjxCLaP3Ipp3dftSsfGEvZpeCvpKjvzGa0QLXiZw7g7GN9oxlmEiRqzkQcEQ2i0sqB6UYoaWPdEf/G3UcPNj3Bn7MOKIQpeB/pguOTqGtn4Oj/okBKNf3cXHJP7O0EqQmGvSqDURCIPEHYeeqSEDv2ajPs11sjr8/2+kkkPYrJ7f5rUJfBPfwXgiA=;5:CD+LpfRXLjaQdzQITIAdRdKjfFXb1OrSujVA0dGIb0bJ8Hxh1FOvX7yg1g5sZhWi9fTcZyWbdEBbpwFFkzJyaAnF03clxzMNvSBrImpA9DyAXfsSPAgL+UgmMUUodKEICoGyU0voObElRO1cWowZbg==;24:MOZ600Lw/tRMOXsHlbduFy/jxpG8ugIPVL8Yq108ByP9bjVUfjVoNi/aW3gVbM2e2rcpTZOLufJWF/0Gl3MNR8Rio+Ua9Kax90adaqw42DA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0101MB1616;7:J08U9TY6AFeHBmfD3Q9Ti3J8Ya90xuifMAmM2Oa1jH22pD0rmI2faRi34uyzyAGzCMDSpwaNDdTYaiCXCw666BTM5/iz+gHh/zNW7Otkfa7h+qkd9MDJUWJYeQK/SUpydXMggiVFEnFOP4YDim8HAtCq/Rys0izuHixeAdSvYipuvzi9eIzxxsIcttGIYpygzNVenKDcXUe1KE82awt4ytkEoPFyNYQ5sdfPbCSpDg0QxZa/P/5GiImtlbEkwex7LQ2obOZPNTV0aESZYjEhYUsa+EstJ9h187CjKYq5mO+/kcKpz9M8wTzT0WedKMRmZK3MUdtTgYJrBj47wFMN77N9p73iq3SHnkEcUESRdIjiqAAHjKfVn8r21ChyQ1VQKt2w8SAkRhi16mBB31UPMK5L/SS5ci1ALF0NaXaeDCKvnrbDry6IRE0rc36E+r4GuLyum+xJ6Aw3+SevS/iyzA==
X-OriginatorOrg: ucl.ac.uk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2016 02:00:40.0962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0101MB1616
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The UCL E-Mail Virus Protection System has been triggered by a message you sent.

One or more of the original e-mail attachments have been removed and replaced with this message.

* The attachment may have contained a virus or malware
* The attachment may have an extension of a type unacceptable for UCL

Consider renaming the file extension (eg rename file.ext to file.ex_)
to avoid this constraint.  The recipient will be required to rename the
file back to its original extension.

--
UCL E-mail Virus Protection System
Servicedesk@ucl.ac.uk
Phone: +44 (0)20 767925000 
Internal phone: 25000

--- Additional Information ---:

Subject: 
Sender: git@vger.kernel.org

Time received: 12/26/2016 2:00:38 AM
Message ID:<148271762999.4343.17263403035894855886@lancernet.com.br>
Detections found: 
EMAIL-7982877765.zip	 JS/Swabfex.C
